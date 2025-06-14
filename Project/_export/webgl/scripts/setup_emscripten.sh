#!/bin/bash
# Usage: setup emscripten dependencies in the executed directory
#
# this script needed until following clear:
# https://github.com/emscripten-core/emscripten/issues/21529
# 
# todo: create version that doesn't need project.data?
# note: !/bin/bash -e doesn't seem to work
#--------------------------------------------------------------
set -e

# test: python exists
python --version

echo ""

# execute: install emsdk 
# (full installation required for file_packager.py to run. 
#  refer to PR above for details)
if [ ! -d "./emsdk" ]; then
	git clone https://github.com/emscripten-core/emsdk
	echo "cloned emsdk"
	echo ""
fi

cd emsdk

python ./emsdk.py install latest
python ./emsdk.py activate latest

echo ""

emscripten_tools_path="$(realpath ./)"
emscripten_tools_file_packager_path="$emscripten_tools_path/upstream/emscripten/tools/file_packager.py"

# test: file_packager exists
if [ ! -f "$emscripten_tools_file_packager_path" ]; then
	echo "error: '$emscripten_tools_file_packager_path' does not exist"
	exit 1 # terminate and indicate error
fi

# provide: user-friendly path
echo "paste: '$emscripten_tools_path' in scripts/emsdk_directory.txt"
