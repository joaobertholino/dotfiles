#!/bin/sh
value=$(df --output=pcent /home | tail -1 | tr -d ' ')
printf '<span font_desc="Font Awesome 7 Free Solid 10"></span> %s\n' "$value"
