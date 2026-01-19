FROM fluent/fluentd:v1.19.0-debian-2.1

COPY fluent.conf /fluentd/etc/fluent.conf

# Install plugins
USER root

ENV PATH /fluentd/vendor/bundle/ruby/2.7.0/bin:$PATH
ENV GEM_PATH /fluentd/vendor/bundle/ruby/2.7.0
ENV GEM_HOME /fluentd/vendor/bundle/ruby/2.7.0
# skip runtime bundler installation
ENV FLUENTD_DISABLE_BUNDLER_INJECTION 1

COPY Gemfile* /fluentd/
RUN set -x \
  && apt-get update \
  && apt-get -y install libsystemd0 \
  && export BUILD_DEPS='ruby-dev gcc g++ make libc-dev libffi-dev' \
  && apt-get install -y --no-install-recommends ${BUILD_DEPS} \
  && gem install bundler --version 2.1.4 \
  && bundle install --gemfile=/fluentd/Gemfile \
  && gem sources --clear-all \
  && apt-get --purge autoremove -y ${BUILD_DEPS} \
  && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/* \
  && rm -rf ${GEM_HOME}/cache/* ${GEM_HOME}/cache/* /root/.bundle/cache/* \
  ;

USER fluent
