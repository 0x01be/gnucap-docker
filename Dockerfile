FROM 0x01be/gnucap:build-python

WORKDIR /gnucap-custom

ENV REVISION=develop
RUN apk add --no-cache --virtual gnucap-custom-build-dependencies \
    readline-dev \
    boost-dev &&\
    git clone --depth 1 --branch ${REVISION} https://codeberg.org/gnucap/gnucap-custom.git /gnucap-custom &&\
    ./configure --prefix=/opt/gnucap &&\
    make
RUN make install

