# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
#ARG OWNER=jupyter
#ARG BASE_CONTAINER=$OWNER/minimal-notebook
#FROM $BASE_CONTAINER
FROM jupyter/minimal-notebook:latest

LABEL maintainer="Carsten <ehbrecht@dkrz.de>"

USER root

# ffmpeg for matplotlib
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends ffmpeg && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

# Install Python 3 packages
RUN mamba install --quiet --yes \
    'bokeh' \
    'jupyter_bokeh' \
    'bottleneck' \
    'cloudpickle' \
    'conda-forge::blas=*=openblas' \
    'cython' \
    'dill' \
    'dask' \
    'dask-memusage' \
    'filprofiler' \
    'nbresuse' \
    'jupyterlab-topbar' \
    'jupyterlab-system-monitor' \
    'matplotlib' \
    'pandas' \
    'intake' \
    'intake-esm' \
    'gcsfs' \
    'zarr' \
    'fsspec' \
    'netcdf4' \
    'humanize' \
    'cachey' \
    'xarray' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME="/home/${NB_USER}/.cache/"

RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions "/home/${NB_USER}"

USER ${NB_UID}

WORKDIR "${HOME}"
