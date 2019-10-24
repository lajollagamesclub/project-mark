#!/usr/bin/env bash

if [ ! -f "tmp.tres" ]; then # avoid overriding previously cached tmp ( after failed script )
	cp /home/creikey/.config/godot/editor_settings-3.tres tmp.tres
fi

rm -r exports
mkdir -p exports/web
mkdir -p exports/linux
mkdir -p exports/windows
godot-headless --path src --export web "$(readlink -f ./exports/web/index.html)"
godot-headless --path src --export windows "$(readlink -f ./exports/windows/project-mark.exe)"
godot-headless --path src --export linux "$(readlink -f ./exports/linux/project-mark.x86_64)"
if [ "$?" == "0" ]; then
	butler push exports/web lajollagamesclub/project-mark:web 
	butler push exports/windows lajollagamesclub/project-mark:windows
	butler push exports/linux lajollagamesclub/project-mark:linux
fi

mv tmp.tres /home/creikey/.config/godot/editor_settings-3.tres
