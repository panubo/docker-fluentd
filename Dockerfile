FROM docker.io/fluent/fluentd:v0.12

USER root

RUN apk update \
 && apk add --no-cache --virtual .build-deps \
        build-base \
        ruby-dev \
 && fluent-gem install --no-document fluent-plugin-kubernetes_metadata_filter -v 0.26.2 \
 && fluent-gem install --no-document fluent-plugin-s3 -v 0.8.1 \
 && fluent-gem install --no-document fluent-plugin-logio -v 1.1.0 \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY out_logio.rb /usr/lib/ruby/gems/2.3.0/gems/fluent-plugin-logio-1.1.0/lib/fluent/plugin/out_logio.rb
