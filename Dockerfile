FROM unifem/coupler-desktop:latest
LABEL maintainer "Qiao Chen <benechiao@gmail.com>"

USER root
WORKDIR /tmp

ARG BITBUCKET_PASS
ARG BITBUCKET_USER

# install meshio
RUN apt-get update && \
    pip3 install -U meshio

# pyoverture
RUN git clone --depth=1 https://${BITBUCKET_USER}:${BITBUCKET_PASS}@bitbucket.org/${BITBUCKET_USER}/pyovcg.git && \
    cd pyovcg && \
    python3 setup.py install

# pydtk2
# make sure add env CC=mpicxx
RUN git clone --depth=1 https://${BITBUCKET_USER}:${BITBUCKET_PASS}@bitbucket.org/${BITBUCKET_USER}/pydtk2.git && \
    cd pydtk2 && \
    env CC=mpicxx python3 setup.py install

# fem solver
RUN git clone --depth=1 https://${BITBUCKET_USER}:${BITBUCKET_PASS}@bitbucket.org/${BITBUCKET_USER}/fesol.git && \
    cd fesol && \
    python3 setup.py install

RUN rm -rf /tmp/*
