FROM unifem/coupler-desktop:latest
LABEL maintainer "Qiao Chen <benechiao@gmail.com>"

USER root
WORKDIR /tmp

ARG BITBUCKER_PASS

# install meshio
RUN apt-get update && \
    pip3 install -U meshio

# pyoverture
RUN git clone --depth=1 https://QiaoC:${BITBUCKER_PASS}@bitbucket.org/QiaoC/pyovcg.git && \
    cd pyovcg && \
    python3 setup.py install

# pydtk2
# make sure add env CC=mpicxx
RUN git clone --depth=1 https://QiaoC:${BITBUCKER_PASS}@bitbucket.org/QiaoC/pydtk2.git && \
    cd pydtk2 && \
    env CC=mpicxx python3 setup.py install

# fem solver
RUN git clone --depth=1 https://QiaoC:${BITBUCKER_PASS}@bitbucket.org/QiaoC/fesol.git && \
    cd fesol && \
    python3 setup.py install

RUN rm -rf /tmp/*
