FROM 0x01be/gnucap:build-python as build

FROM 0x01be/base

WORKDIR /workspace

COPY --from=build /opt/gnucap/ /opt/gnucap/
COPY --from=build /gnucap-python/examples/ /opt/gnucap/examples/

RUN apk add --no-cache --virtual gnucap-runtime-dependencies \
    python3 \
    py3-numpy \
    libstdc++ &&\
    adduser -D -u 1000 gnucap &&\
    chown gnucap:gnucap /workspace

USER gnucap
ENV LD_LIBRARY_PATH=/lib:/usr/lib:/opt/gnucap/lib \
    PATH=${PATH}:/opt/gnucap/bin \
    PYTHONPATH=/usr/lib/python3.8/site-packages:/opt/gnucap/lib/python3.8/site-packages

