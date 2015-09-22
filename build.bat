@echo off
SET dir=%~dp0
cd %dir%
if exist drderico-ga.zip del /F drderico-ga.zip
zip -r -9 drderico-ga.zip extension haxelib.json include.xml dependencies LICENSE.md README.md
pause