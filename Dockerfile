FROM colomoto/colomoto-docker-base:R
MAINTAINER CoLoMoTo Group <contact@colomoto.org>

USER root

# IMPORTANT:
# DO NOT UPDATE PACKAGE VERSIONS MANUALLY
# USE python update-n-freeze.py

RUN conda install --no-update-deps  -y \
        -c potassco/label/dev \
        clingo=5.4.0=py37hf484d3e_8 \
        boolsim=1.2=0 \
        bns=1.3=0 \
        its=20180905=0 \
        nusmv=2.6.0=0 \
        nusmv-arctl=2.2.2=0 \
        maboss=2.1.0=0 \
    && conda clean -y --all && rm -rf /opt/conda/pkgs

RUN conda install --no-update-deps -y \
        ginsim=3.0.0b=6 \
        pint=2019.05.24=1 \
        r-boolnet=2.1.5=r351hcdcec82_0 \
    && conda clean -y --all && rm -rf /opt/conda/pkgs

RUN conda install --no-update-deps -y \
        boolean.py=3.5+git=py_0 \
        colomoto_jupyter=0.5.4=py_0 \
        ginsim-python=0.3.6=py_0 \
        pymaboss=0.7.2=py_0 \
        pypint=1.5.2=py_0 \
    && conda clean -y --all && rm -rf /opt/conda/pkgs

COPY validate.sh /usr/local/bin/


##
# Notebooks
##
## Tutorials for individual tools
#COPY --chown=user:user tutorials /notebook/tutorials
#COPY usecases/*.ipynb /notebook/usecases/
COPY usecases /notebook/usecases/
COPY tutorials /notebook/tutorials

# hub.docker.org does not support COPY --chown yet
RUN chown -R user:user /notebook

USER user
ARG IMAGE_NAME
ARG IMAGE_BUILD_DATE
ARG BUILD_DATETIME
ARG SOURCE_COMMIT
ENV DOCKER_IMAGE=$IMAGE_NAME \
    DOCKER_BUILD_DATE=$IMAGE_BUILD_DATE \
    DOCKER_SOURCE_COMMIT=$SOURCE_COMMIT
LABEL org.label-schema.build-date=$BUILD_DATETIME \
    org.label-schema.name="The CoLoMoTo docker" \
    org.label-schema.url="http://colomoto.org/" \
    org.label-schema.vcs-ref=$SOURCE_COMMIT \
    org.label-schema.vcs-url="https://github.com/colomoto/colomoto-docker" \
    org.label-schema.schema-version="1.0"

