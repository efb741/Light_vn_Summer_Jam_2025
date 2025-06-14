#!/bin/bash
# Assumption: execution at main level
# sh ./scripts/package.sh
#
# note: !/bin/bash -e doesn't seem to work
#--------------------------------------------------------------
set -e

emsdk_path=$(head -n 1 $(dirname "$0")/emsdk_directory.txt)
emscripten_tools_path="$emsdk_path/upstream/emscripten/tools"

echo $emsdk_path

cd ./data
py "$emscripten_tools_path/file_packager.py" project.data --js-output=loader.js --preload ./

# Note: need to manually copy these back to top-level directory due to
# file_packager.py creating invalid loader.js configuration when passing relative values

cp project.data ../project.data
cp loader.js ../loader.js
