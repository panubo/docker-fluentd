FROM docker.io/fluent/fluentd:v1.1.0

USER root

RUN set -x \
 && apk update \
 && apk add --no-cache --virtual .build-deps \
        build-base \
        ruby-dev \
 && fluent-gem install --no-document fluent-plugin-kubernetes_metadata_filter -v 1.0.1 \
 && fluent-gem install --no-document fluent-plugin-s3 -v 1.1.1 \
 && fluent-gem install --no-document fluent-plugin-systemd -v 0.3.1 \
 && fluent-gem install --no-document fluent-plugin-record-reformer -v 0.9.1 \
 && fluent-gem install --no-document fluent-plugin-sumologic_output -v 1.0.1 \
 && fluent-gem install --no-document fluent-plugin-concat -v 2.2.0 \
 && gem sources -c \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

ENV BUILD_VERSION 1.1.0-1
