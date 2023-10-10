FROM alpine
SHELL ["/bin/sh", "-c"]

# tool for build
RUN apk update \
    && apk add \
                git \
                g++

WORKDIR crumbicon
COPY . .

# build crumb interpreter from source
RUN chmod +x build-crumb.sh && ./build-crumb.sh
