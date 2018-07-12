FROM unifem/coupler-desktop:latest as base

USER root
WORKDIR $DOCKER_HOME

ARG BITBUCKET_PASS
ARG BITBUCKET_USER

ADD image $DOCKER_HOME/

# install meshio
RUN apt-get update && \
    pip3 install -U meshio

# pyoverture
RUN git clone --depth=1 https://${BITBUCKET_USER}:${BITBUCKET_PASS}@bitbucket.org/${BITBUCKET_USER}/pyovcg.git

# pydtk2
# make sure add env CC=mpicxx
RUN git clone --depth=1 https://${BITBUCKET_USER}:${BITBUCKET_PASS}@bitbucket.org/${BITBUCKET_USER}/pydtk2.git

# fem solver
RUN git clone --depth=1 https://${BITBUCKET_USER}:${BITBUCKET_PASS}@bitbucket.org/${BITBUCKET_USER}/fesol.git

# lbcalculix
RUN git clone --depth=1 https://${BITBUCKET_USER}:${BITBUCKET_PASS}@bitbucket.org/${BITBUCKET_USER}/libcalculix.git

# pyccx
RUN git clone --depth=1 https://${BITBUCKET_USER}:${BITBUCKET_PASS}@bitbucket.org/${BITBUCKET_USER}/pyccx.git

RUN chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

WORKDIR $DOCKER_HOME
USER root

### second stage
FROM unifem/coupler-desktop:latest
LABEL maintainer "Qiao Chen <benechiao@gmail.com>"

USER root
WORKDIR /tmp

COPY --from=base $DOCKER_HOME/pyovcg .
COPY --from=base $DOCKER_HOME/pydtk2 .
COPY --from=base $DOCKER_HOME/fesol .
COPY --from=base $DOCKER_HOME/libcalculix .
COPY --from=base $DOCKER_HOME/pyccx .

RUN cd pyovcg && python3 setup.py install
RUN cd pydtk2 && env CC=mpicxx python3 setup.py install
RUN cd fesol && python3 setup.py install
RUN cd libcalculix && make && make install
RUN cd pyccx && python3 setup.py install

RUN rm -rf /tmp/*

RUN chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

WORKDIR $DOCKER_HOME
USER root
