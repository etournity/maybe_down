#!/bin/sh
echo -ne '\033c\033]0;gmtk_23\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/gmtk_23.x86_64" "$@"
