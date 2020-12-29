FROM 0x01be/gnucap:build as build

FROM 0x01be/base

WORKDIR /workspace

COPY --from=build /opt/gnucap/ /opt/gnucap/

RUN apk add --no-cache --virtual gnucap-runtime-dependencies \
    libstdc++ &&\
    adduser -D -u 1000 gnucap &&\
    chown gnucap:gnucap /workspace

USER gnucap
ENV LD_LIBRARY_PATH=/lib:/usr/lib:/opt/gnucap/lib \
    PATH=${PATH}:/opt/gnucap/bin
