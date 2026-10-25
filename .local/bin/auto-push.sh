#!/usr/bin/env bash
# Salva e envia submódulos recursivamente antes do repositório principal.
set -euo pipefail
export PATH="/usr/local/bin:/usr/bin:/bin:${PATH:-}"
export GIT_TERMINAL_PROMPT=0
export GIT_SSH_COMMAND="${GIT_SSH_COMMAND:-ssh -o BatchMode=yes -o ConnectTimeout=15}"
state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-auto-push"
mkdir -p "$state_dir"
exec 9>"$state_dir/run.lock"
flock -n 9 || exit 0
python3 - "$@" <<'PY'
import os,sys,subprocess
from pathlib import Path
root=Path(os.environ.get('DOTFILES_ROOT',str(Path.home()))).resolve()
dry=sys.argv[1:]==['--dry-run']
if sys.argv[1:] and not dry:
    raise SystemExit('Uso: auto-push.sh [--dry-run]')

def git(repo,*args,check=True):
    r=subprocess.run(['git','-C',str(repo),*args],text=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    if check and r.returncode:
        raise RuntimeError(f'{repo}: git {args[0]} falhou: {r.stderr.strip()}')
    return r

def children(repo):
    if not (repo/'.gitmodules').is_file():return []
    r=git(repo,'config','--null','--file','.gitmodules','--get-regexp',r'^submodule\..*\.path$',check=False)
    if r.returncode not in (0,1):raise RuntimeError(f'.gitmodules inválido: {repo}')
    result=[]
    for entry in r.stdout.split('\0'):
        if not entry:continue
        path=entry.split('\n',1)[1]
        child=(repo/path).resolve()
        if not child.is_relative_to(repo) or child==repo:raise RuntimeError(f'Caminho de submódulo inválido: {path}')
        if not (child/'.git').exists():raise RuntimeError(f'Submódulo não inicializado: {child}')
        result.append(child)
    return result

def sync(repo):
    top=Path(git(repo,'rev-parse','--show-toplevel').stdout.strip()).resolve()
    if top!=repo:raise RuntimeError(f'Não é a raiz de um repositório: {repo}')
    for child in children(repo):sync(child)
    if git(repo,'ls-files','--unmerged').stdout:raise RuntimeError(f'Conflitos não resolvidos: {repo}')
    branch=git(repo,'symbolic-ref','--quiet','--short','HEAD',check=False).stdout.strip()
    if not branch:raise RuntimeError(f'HEAD destacado: {repo}')
    remotes=git(repo,'remote').stdout.splitlines()
    remote='personal' if 'personal' in remotes else 'origin' if 'origin' in remotes else None
    if remote is None:raise RuntimeError(f'Sem remoto configurado: {repo}')
    if dry:
        print(f'[simulação] {repo} -> {remote}/{branch}',flush=True)
        print(git(repo,'status','--short').stdout,end='',flush=True)
        return
    git(repo,'add','--all')
    if git(repo,'diff','--cached','--quiet',check=False).returncode==1:
        out=git(repo,'commit','-m','chore: automatic configuration update').stdout
        print(out,end='',flush=True)
    # Verifica a ponta remota; nunca força push nem altera configurações com pull.
    ref='refs/heads/'+branch
    exists=git(repo,'ls-remote','--exit-code','--heads',remote,ref,check=False)
    if exists.returncode==0:
        git(repo,'fetch','--no-tags',remote,ref)
        if git(repo,'merge-base','--is-ancestor','FETCH_HEAD','HEAD',check=False).returncode:
            raise RuntimeError(f'{repo}: o remoto avançou ou divergiu; integre {remote}/{branch} antes do próximo envio.')
    elif exists.returncode!=2:
        raise RuntimeError(f'{repo}: não foi possível consultar {remote}: {exists.stderr.strip()}')
    r=git(repo,'push','--recurse-submodules=check',remote,'HEAD:'+ref)
    print(f'[enviado] {repo} -> {remote}/{branch}',flush=True)
    if r.stderr:print(r.stderr,end='',flush=True)

try:
    sync(root)
except Exception as e:
    print(f'ERRO: {e}',file=sys.stderr,flush=True)
    sys.exit(1)
PY
