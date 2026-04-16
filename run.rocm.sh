#!/bin/bash
VIDEO_ID=`getent group video | cut -d: -f3`
RENDER_ID=`getent group render | cut -d: -f3`

irsl_docker_irsl_system/run.sh --no-gpu -w $(pwd) --docker-option "--device=/dev/kfd --device=/dev/dri --security-opt seccomp=unconfined -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro --group-add ${VIDEO_ID} --group-add ${RENDER_ID} --ipc=host --shm-size=8g" --name robomanip --image base_line_manip:irsl_one_rocm

### for exec
# docker exec -it robomanip  bash
