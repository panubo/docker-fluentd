FROM fluent/fluentd:v1.4.1-debian-1.1

# Fluentd w/ AWS and systemd plugins
COPY fluent.conf /fluentd/etc/fluent.conf

# Install plugins
USER root
RUN set -x \
  && apt-get update \
  && apt-get -y install libsystemd0 \
  && export BUILD_DEPS='ruby-dev gcc g++ make' \
  && apt-get install -y --no-install-recommends ${BUILD_DEPS} \
  && fluent-gem install fluent-plugin-record-modifier -v 1.1.0 \
  && fluent-gem install fluent-plugin-concat -v 2.3.0 \
  && fluent-gem install fluent-plugin-detect-exceptions -v 0.0.12 \
  && fluent-gem install fluent-plugin-kubernetes_metadata_filter -v 2.1.6 \
  && fluent-gem install fluent-plugin-multi-format-parser -v 1.0.0 \
  && fluent-gem install fluent-plugin-prometheus -v 1.3.0 \
  && fluent-gem install oj -v 3.7.11 \
  && fluent-gem install fluent-plugin-systemd -v 1.0.2 \
  && fluent-gem install fluent-plugin-cloudwatch-logs -v 0.7.3 \
  && fluent-gem install fluent-plugin-s3 -v 1.1.9 \
  && fluent-gem sources --clear-all \
  && apt-get --purge autoremove -y ${BUILD_DEPS} \
  && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/* \
  ;
USER fluent
