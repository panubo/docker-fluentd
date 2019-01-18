FROM fluent/fluentd:v1.3.3-debian-1.0

USER root
# Install gomplate
RUN set -x \
  && GOMPLATE_VERSION=v2.5.0 \
  && GOMPLATE_CHECKSUM=f4cc9567c1a7b3762af175cf9d941fddef3b5032354c210604fb015c229104c7 \
  && apt-get update \
  && export BUILD_DEPS='curl' \
  && apt-get install -y --no-install-recommends ${BUILD_DEPS} \
  && curl -sS -o /tmp/gomplate_linux-amd64-slim -L https://github.com/hairyhenderson/gomplate/releases/download/${GOMPLATE_VERSION}/gomplate_linux-amd64-slim \
  && echo "${GOMPLATE_CHECKSUM}  gomplate_linux-amd64-slim" > /tmp/SHA256SUM \
  && ( cd /tmp; sha256sum -c SHA256SUM; ) \
  && mv /tmp/gomplate_linux-amd64-slim /usr/local/bin/gomplate \
  && chmod +x /usr/local/bin/gomplate \
  && apt-get --purge autoremove -y ${BUILD_DEPS} \
  && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/* \
  ;

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["tini","--","/entrypoint.sh","/bin/entrypoint.sh"]
CMD ["fluentd"]

# Fluentd w/ Sumologic and systemd plugins
COPY fluent.conf /fluentd/etc/fluent.conf.tmpl

ENV BUILD_VERSION 1.3.3-debian-1.0-stresstest-1
