#!/usr/bin/python3
"""Map the lower pen button to middle-click only while Zathura is focused."""
import fcntl
import json
import os
from pathlib import Path
import subprocess
import sys

runtime = Path(os.environ['XDG_RUNTIME_DIR'])
with (runtime / 'zathura-tablet-buttons.lock').open('w') as lock:
    fcntl.flock(lock, fcntl.LOCK_EX)
    def run(*args):
        return subprocess.run(args, capture_output=True, text=True, check=True).stdout.strip()
    window = json.loads(run('hyprctl', 'activewindow', '-j'))
    enabled = 'zathura' in window.get('class', '').lower()
    if '--enable' in sys.argv:
        enabled = True
    if '--disable' in sys.argv:
        enabled = False
    state_path = runtime / 'zathura-tablet-buttons.json'
    state = json.loads(state_path.read_text()) if state_path.exists() else {}
    # Match only the XWayland tablet stylus, never the mouse or eraser.
    for name in run('xinput', 'list', '--name-only').splitlines():
        if not name.startswith('xwayland-tablet stylus:'):
            continue
        device = run('xinput', 'list', '--id-only', name)
        key = os.environ.get('HYPRLAND_INSTANCE_SIGNATURE', '') + ':' + device
        current = [int(x) for x in run('xinput', 'get-button-map', device).split()]
        entry = state.get(key, {})
        if enabled:
            if not entry.get('applied'):
                entry = {'original': current, 'applied': False}
            target = entry['original'].copy()
            if len(target) < 3:
                continue
            target[1], target[2] = 2, 3
            if current != target:
                run('xinput', 'set-button-map', device, *map(str, target))
            entry.update(applied=True, target=target)
            state[key] = entry
        elif entry.get('applied'):
            if current == entry['target']:
                run('xinput', 'set-button-map', device, *map(str, entry['original']))
            entry['applied'] = False
    state_path.write_text(json.dumps(state))
    state_path.chmod(0o600)
