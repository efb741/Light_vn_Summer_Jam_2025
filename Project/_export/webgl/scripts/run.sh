#!/bin/bash
# Assumption: execution at main level
# sh ./scripts/run.sh
#
# note: !/bin/bash -e doesn't seem to work
#--------------------------------------------------------------
set -e

# test: python exists
python --version

pushd .
source ./scripts/package.sh
popd
echo ""

# run server
python ./scripts/server.py --open
