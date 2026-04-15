#!/bin/bash

irsl_docker_irsl_system/run.sh \
--no-gpu \
-w $(pwd) \
--docker-option "--shm-size=8g --device=/dev/kfd --device=/dev/dri --group-add video --ipc=host -e HSA_OVERRIDE_GFX_VERSION=12.0.0" \
--name robomanip \
--image base_line_manip:irsl_one_rocm