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
RUN chmod +x setup.sh && ./setup.sh

# Build Crumbicon
RUN ./loaf crumbicon.crumb crumbicon
