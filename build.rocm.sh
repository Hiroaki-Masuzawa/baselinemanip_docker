#!/bin/bash

OUTPUT_IMAGE=${1:-base_line_manip:irsl_one_rocm}
_INDEX_URL=${INDEX_URL:-https://rocm.nightlies.amd.com/v2/gfx110X-all/}

if [ ! -e irsl_docker_irsl_system ]; then
    git clone https://github.com/IRSL-tut/irsl_docker_irsl_system
fi

set -x

docker build . -f Dockerfile.rocm --build-arg INDEX_URL=${_INDEX_URL} -t ${OUTPUT_IMAGE}
