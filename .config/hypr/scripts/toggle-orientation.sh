#!/usr/bin/env bash
set -euo pipefail

monitor="HDMI-A-1"
transform=$(hyprctl monitors -j | jq -er --arg monitor "$monitor" '.[] | select(.name == $monitor) | .transform')
if [[ "$transform" == "0" ]]; then
    target=1
    label="Portrait"
else
    target=0
    label="Landscape"
fi

python3 - "$target" <<'PYTHON'
from pathlib import Path
import os,re,sys
rotation=int(sys.argv[1])
assert rotation in (0,1)
base=Path.home()/'.config/hypr/modules'
changes=[]
for name in ['monitors.lua','input.lua']:
    path=base/name
    text,count=re.subn(r'(?m)^(\s*transform\s*=\s*)[0-7](\s*,)',lambda m:m[1]+str(rotation)+m[2],path.read_text())
    if count!=1:
        raise SystemExit('Expected exactly one orientation setting in '+str(path))
    changes.append((path,text))
for path,text in changes:
    temporary=path.with_name('.'+path.name+'.orientation')
    temporary.write_text(text)
    temporary.chmod(path.stat().st_mode & 0o777)
    os.replace(temporary,path)
PYTHON

hyprctl reload
notify-send --app-name=Hyprland 'Display and tablet orientation' "$label"
