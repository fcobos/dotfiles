#!/usr/bin/env bash

sudo dnf install dnf-plugins-core
sudo dnf copr enable jdanecki/intel-opencl
sudo dnf install intel-opencl level-zero intel-level-zero-gpu
