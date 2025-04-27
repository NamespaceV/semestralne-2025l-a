# Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
# powershell.exe -File .\build-and-upload-to-itch.ps1

Start-Process -Wait Godot_v4.4-stable_win64.exe '--headless --export-debug "Web" "..\..\export\web\index.html"'
7z a  ..\..\export\web.zip ..\..\export\web\*
butler.exe push ..\..\export\web.zip namespacev/semestralne25l-a:web

Start-Process -Wait Godot_v4.4-stable_win64.exe '--headless --export-debug "Windows" "..\..\export\win\picon.exe"'
7z a  ..\..\export\windows.zip ..\..\export\win\*
butler.exe push ..\..\export\windows.zip namespacev/semestralne25l-a:windows

Start-Process -Wait Godot_v4.4-stable_win64.exe '--headless --export-debug "Linux" "..\..\export\linux\picon.x86_64"'
7z a  ..\..\export\linux.zip ..\..\export\linux\*
butler.exe push ..\..\export\linux.zip namespacev/semestralne25l-a:linux
