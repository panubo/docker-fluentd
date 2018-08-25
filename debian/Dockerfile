FROM fluent/fluentd:v1.2.5-debian

# Fluentd w/ Sumologic and systemd plugins

# Install plugins
RUN apt-get update \
  && apt-get -y install libsystemd0 \
  && export BUILD_DEPS='ruby-dev gcc make' \
  && apt-get -y install ${BUILD_DEPS} \
  && fluent-gem install fluent-plugin-systemd -v 1.0.1 \
  && fluent-gem install fluent-plugin-sumologic_output -v 1.3.0 \
  && apt-get --purge autoremove -y ${BUILD_DEPS} \
  && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

COPY entrypoint.sh /bin/

COPY fluent.conf /fluentd/etc/

ENV BUILD_VERSION 1.2.5-1-debian
