# Docker image for the gcr plugin
#
#     docker build --rm=true -t plugins/gcr .
FROM plugins/docker:17.05

ENV HOME /

RUN \
       apk add -Uuv --no-cache ca-certificates jq \
    && rm -rf /var/cache/apk/*

ADD bin/wrap-drone-docker.sh /bin/wrap-drone-docker.sh


ENTRYPOINT ["/bin/wrap-drone-docker.sh"]

