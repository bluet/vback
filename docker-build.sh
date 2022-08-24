#!/bin/bash

VERSION=1.0.2

docker build --pull -t bluet/vback .
docker scan bluet/vback:latest

docker tag bluet/vback:latest bluet/vback:${VERSION}
git tag "${VERSION}" -a -m "vback ${VERSION}"
git push
git push --tags

# Fixes busybox trigger error https://github.com/tonistiigi/xx/issues/36#issuecomment-926876468
docker run --privileged -it --rm tonistiigi/binfmt --install all

docker buildx create --use

while true; do
        read -p "Have I Updated VERSION Info? (Is current VERSION=${VERSION} ?) [y/N]" yn
        case $yn in
                [Yy]* ) docker buildx build -t bluet/vback:latest -t bluet/vback:${VERSION} --platform linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/s390x,linux/riscv64 --push .; break;;
                [Nn]* ) exit;;
                * ) echo "";;
        esac
done


