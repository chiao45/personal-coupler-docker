FROM unifem/coupler-desktop:latest
LABEL maintainer "Qiao Chen <benechiao@gmail.com>"

USER root
WORKDIR /tmp

ARG BITBUCKET_PASS
ARG BITBUCKET_USER

ADD image $DOCKER_HOME/

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

# lbcalculix
RUN git clone --depth=1 https://${BITBUCKET_USER}:${BITBUCKET_PASS}@bitbucket.org/${BITBUCKET_USER}/libcalculix.git && \
    cd libcalculix && \
    make && \
    make install

# pyccx
RUN git clone --depth=1 https://${BITBUCKET_USER}:${BITBUCKET_PASS}@bitbucket.org/${BITBUCKET_USER}/pyccx.git && \
    cd pyccx && \
    python3 setup.py install

RUN rm -rf /tmp/*

RUN chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

WORKDIR $DOCKER_HOME
USER root
