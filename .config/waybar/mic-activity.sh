#!/usr/bin/python3
import subprocess,json
muted='yes' in subprocess.run(['/usr/local/bin/pactl','get-source-mute','@DEFAULT_SOURCE@'],capture_output=True,text=True).stdout
print(json.dumps({'text':'<span font_desc="Font Awesome 7 Free Solid 10">'+('' if muted else '')+'</span>','class':'red' if muted else 'gray','tooltip':'Microphone muted' if muted else 'Microphone enabled (click to mute)'}))
