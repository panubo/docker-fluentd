FROM fluent/fluentd:v1.3.3-debian-1.0

# Fluentd w/ Sumologic and systemd plugins

# Install plugins
USER root
RUN set -x \
  && apt-get update \
  && apt-get -y install libsystemd0 \
  && export BUILD_DEPS='ruby-dev gcc make' \
  && apt-get install -y --no-install-recommends ${BUILD_DEPS} \
  && fluent-gem install fluent-plugin-systemd -v 1.0.1 \
  && fluent-gem install fluent-plugin-sumologic_output -v 1.3.2 \
  && fluent-gem sources --clear-all \
  && apt-get --purge autoremove -y ${BUILD_DEPS} \
  && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/* \
  ;
USER fluent

ENV BUILD_VERSION 1.3.3-debian-1.0-sumologic-1
