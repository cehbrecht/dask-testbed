#!/usr/bin/env bash
docker run \
  --rm \
  -p 8888:8888 \
  -e JUPYTER_ENABLE_LAB=yes \
  -v "${PWD}/..":/home/jovyan/work \
  --cpus="1.0" \
  --memory="1024m" \
  --memory-reservation="1024m" \
  notebook
