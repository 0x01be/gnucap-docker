FROM 0x01be/gnucap:build-python as build

FROM 0x01be/base

COPY --from=build /opt/gnucap/ /opt/gnucap/

RUN apk add --no-cache --virtual gnucap-runtime-dependencies \
    libstdc++ \
    python3

ENV LD_LIBRARY_PATH=/lib:/usr/lib:/opt/gnucap/lib \
    PATH=${PATH}:/opt/gnucap/bin \
    PYTHONPATH=/usr/lib/python3.8/site-packages:/opt/gnucap/lib/python3.8/site-packages

