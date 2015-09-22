#!/bin/bash
dir=`dirname "$0"`
cd "$dir"
haxelib remove drderico-ga
haxelib local drderico-ga.zip
