#!/bin/bash
rm -rf build
mkdir build

rasm -eo -xr -utf8 -rasm -os build/PROJECT_NAME.sym src/main.asm
