FROM 0x01be/gnucap:build as build

FROM 0x01be/base

COPY --from=build /opt/gnucap/ /opt/gnucap/

RUN apk add --no-cache --virtual gnucap-runtime-dependencies \
    libstdc++

ENV LD_LIBRARY_PATH=/lib:/usr/lib:/opt/gnucap/lib/ \
    PATH=${PATH}:/opt/bin/gnucap
