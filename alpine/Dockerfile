FROM docker.io/fluent/fluentd:v1.2.5

RUN set -x \
 && apk update \
 && apk add shadow \
 && apk add --no-cache --virtual .build-deps \
        build-base \
        ruby-dev \
 && fluent-gem install --no-document fluent-plugin-kubernetes_metadata_filter -v 2.1.2 \
 && fluent-gem install --no-document fluent-plugin-s3 -v 1.1.4 \
 && fluent-gem install --no-document fluent-plugin-record-reformer -v 0.9.1 \
 && fluent-gem install --no-document fluent-plugin-sumologic_output -v 1.3.0 \
 && fluent-gem install --no-document fluent-plugin-concat -v 2.3.0 \
 && gem sources -c \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

ENV BUILD_VERSION 1.2.5-1-alpine
