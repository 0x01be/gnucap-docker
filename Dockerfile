FROM 0x01be/swig:3.0 as swig

FROM 0x01be/gnucap

COPY --from=swig /opt/swig/ /opt/swig/

WORKDIR /gnucap-python

ENV REVISION=develop
RUN apk add --no-cache --virtual gnucap-python-build-dependencies \
    git \
    build-base \
    autoconf \
    automake \
    libtool \
    pcre \
    sed \
    python3-dev \
    py3-numpy-dev &&\
    git clone --depth 1 --branch ${REVISION} https://codeberg.org/gnucap/gnucap-python.git /gnucap-python

ENV PATH=${PATH}:/opt/swig/bin \
    LDFLAGS='-L/opt/gnucap/lib' \
    CPPFLAGS='-I/opt/gnucap/include -I/opt/gnucap/include/gnucap -I/usr/lib/python3.8/site-packages/numpy/core/include' \
    LD_LIBRARY_PATH=/lib:/usr/lib:/opt/gnucap/lib \
    SWIG=/opt/swig/bin/swig
RUN ./bootstrap &&\
    ./configure --prefix=/opt/gnucap
RUN i=0; while [ $i -le 33 ]; do make install || true; i=$((i+1)); done
#    until [ $(make install 2>&1 | grep '???') ]; do printf "."; done

RUN cp -R /gnucap-python/examples/ /opt/gnucap/share/examples/

