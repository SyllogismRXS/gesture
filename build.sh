#!/bin/bash

mkdir -p ./build

pushd ./build >& /dev/null

cmake ..

make

popd >& /dev/null
