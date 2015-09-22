#!/bin/bash
dir=`dirname "$0"`
cd "$dir"
rm -f drderico-ga.zip
zip -0r drderico-ga.zip extension haxelib.json include.xml dependencies LICENSE.md README.md

