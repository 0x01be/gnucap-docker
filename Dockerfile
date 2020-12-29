FROM 0x01be/gnucap:build-full as build

FROM 0x01be/base

WORKDIR /workspace

COPY --from=build /opt/gnucap/ /opt/gnucap/

RUN apk add --no-cache --virtual gnucap-runtime-dependencies \
    python3 \
    py3-numpy \
    libstdc++ &&\
    adduser -D -u 1000 gnucap &&\
    chown gnucap:gnucap /workspace

USER gnucap
ENV LD_LIBRARY_PATH=/lib:/usr/lib:/opt/gnucap/lib:/opt/gnucap/lib/gnucap:/opt/gnucap/lib/python3.8/site-packages/gnucap \
    PATH=${PATH}:/opt/gnucap/bin \
    PYTHONPATH=/usr/lib/python3.8/site-packages:/opt/gnucap/lib/python3.8/site-packages

