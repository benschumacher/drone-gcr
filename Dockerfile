# Docker image for the ecr plugin
#
#     docker build --rm=true -t plugins/ecr .
FROM plugins/docker:1.13

ENV HOME /
ENV PATH /google-cloud-sdk/bin:$PATH

RUN \
       apk add -Uuv --no-cache ca-certificates jq \
    && rm -rf /var/cache/apk/*

ADD bin/wrap-drone-docker.sh /bin/wrap-drone-docker.sh


ENTRYPOINT ["/bin/wrap-drone-docker.sh"]

