#!/usr/bin/env bash
docker run \
  --rm \
  -p 8888:8888 \
  -e JUPYTER_ENABLE_LAB=yes \
  -v "${PWD}/..":/home/jovyan/work \
  --cpus="4.0" \
  --memory="4048mb" \
  dask/dev
