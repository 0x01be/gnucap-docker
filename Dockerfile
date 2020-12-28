FROM 0x01be/base

WORKDIR /gnucap

ENV REVISION=develop
RUN apk add --no-cache --virtual gnucap-build-dependencies \
    git \
    build-base \
    readline-dev

RUN git clone --depth 1 --branch ${REVISION} git://git.savannah.gnu.org/gnucap.git /gnucap

RUN ./configure --prefix=/opt/gnucap
RUN make
RUN make install

