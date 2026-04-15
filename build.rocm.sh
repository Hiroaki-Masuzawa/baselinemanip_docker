#!/bin/bash

OUTPUT_IMAGE=${1:-base_line_manip:irsl_one_rocm}

if [ ! -e irsl_docker_irsl_system ]; then
    git clone https://github.com/IRSL-tut/irsl_docker_irsl_system
fi

set -x

docker build . -f Dockerfile.rocm -t ${OUTPUT_IMAGE}
