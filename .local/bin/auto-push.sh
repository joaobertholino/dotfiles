#!/usr/bin/env bash

# Faz backup dos repositórios de configuração locais. Um repositório sem o
# remoto "personal" é mantido localmente e não impede os demais de serem enviados.
set -u

DOTFILES_ROOT="${HOME}/"
LY_REPOSITORY="/etc/ly"
COMMIT_MESSAGE="chore: automatic configuration update"

commit_and_push() {
  local repository="$1"
  local branch

  if ! git -C "$repository" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    printf 'Skipping %s: not a Git repository.\n' "$repository" >&2
    return 0
  fi

  git -C "$repository" add -A
  if ! git -C "$repository" diff --cached --quiet; then
    git -C "$repository" commit -m "$COMMIT_MESSAGE"
  fi

  branch="$(git -C "$repository" branch --show-current)"
  if [ -z "$branch" ]; then
    printf 'Skipping push for %s: detached HEAD.\n' "$repository" >&2
    return 0
  fi

  if git -C "$repository" remote get-url personal >/dev/null 2>&1; then
    git -C "$repository" push personal "HEAD:refs/heads/${branch}" || true
  else
    printf 'Skipping push for %s: remote "personal" is not configured.\n' "$repository" >&2
  fi
}

# Primeiro atualiza os submódulos já declarados pelo repositório principal.
while IFS= read -r submodule; do
  [ -n "$submodule" ] && commit_and_push "$DOTFILES_ROOT/$submodule"
done < <(git -C "$DOTFILES_ROOT" config --file .gitmodules --get-regexp '^submodule\..*\.path$' 2>/dev/null | awk '{print $2}')

# /etc/ly é um repositório separado; ~/.config/ly-dm é apenas um link simbólico.
commit_and_push "$LY_REPOSITORY"
commit_and_push "$DOTFILES_ROOT"
