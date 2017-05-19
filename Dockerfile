# Docker image for the ecr plugin
#
#     docker build --rm=true -t plugins/ecr .
FROM plugins/docker:1.13

ENV HOME /
ENV PATH /google-cloud-sdk/bin:$PATH

RUN \
       apk add -Uuv --no-cache \
           curl python py2-openssl bash ca-certificates jq strace \
    && rm -rf /var/cache/apk/* \
    && (curl https://sdk.cloud.google.com | bash) \
#    && gcloud components install docker-credential-gcr \
# adduser arguments:
#   -D        Don't assign a password
#   -S        Create a system user
#   -h DIR    Home directory
#   -s SHELL  Login shell
#   -u UID    User id
#    && adduser -D -u 50 -h /home/gcloud -s /bin/bash gcloud
    && mkdir -p /home/gcloud

ADD bin/wrap-drone-docker.sh /bin/wrap-drone-docker.sh

ENV HOME /home/gcloud
RUN \
       gcloud config set disable_usage_reporting true \
    && gcloud config set component_manager/disable_update_check true


ENTRYPOINT ["/bin/wrap-drone-docker.sh"]

