@echo off
SET dir=%~dp0
cd %dir%
haxelib remove drderico-ga
haxelib local drderico-ga.zip
