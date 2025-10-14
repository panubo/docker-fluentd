FROM docker.io/fluent/fluentd:v1.19.0-2.1

USER root

# Install gomplate
RUN set -x \
  && GOMPLATE_VERSION=v3.11.6 \
  && GOMPLATE_CHECKSUM_X86_64=7ce8f9f89a0b21fac05b8412af4dd8a06f9e5d8a2df70370549d2dde5f9f0d75 \
  && GOMPLATE_CHECKSUM_AARCH64=f41b6cfaebd9c744c3091993baf9ca44cd80e07d63143d2e78457a159fc22dc5 \
  && BUILD_DEPS='curl' \
  && apt-get update \
  && apt-get install -y --no-install-recommends ${BUILD_DEPS} \
  && if [ "$(uname -m)" = "x86_64" ] ; then \
        GOMPLATE_CHECKSUM="${GOMPLATE_CHECKSUM_X86_64}"; \
        GOMPLATE_ARCH="amd64"; \
      elif [ "$(uname -m)" = "aarch64" ]; then \
        GOMPLATE_CHECKSUM="${GOMPLATE_CHECKSUM_AARCH64}"; \
        GOMPLATE_ARCH="arm64"; \
      fi \
  && curl -sSf -o /tmp/gomplate_linux-${GOMPLATE_ARCH} -L https://github.com/hairyhenderson/gomplate/releases/download/${GOMPLATE_VERSION}/gomplate_linux-${GOMPLATE_ARCH} \
  && echo "${GOMPLATE_CHECKSUM}  gomplate_linux-${GOMPLATE_ARCH}" > /tmp/SHA256SUM \
  && ( cd /tmp; sha256sum -c SHA256SUM || ( echo "Expected $(sha256sum gomplate_linux-${GOMPLATE_ARCH})"; exit 1; )) \
  && install -m 0755 /tmp/gomplate_linux-${GOMPLATE_ARCH} /usr/local/bin/gomplate \
  && apt-get --purge autoremove -y ${BUILD_DEPS} \
  && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/* \
  ;

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["tini","--","/entrypoint.sh","/bin/entrypoint.sh"]
CMD ["fluentd"]

# Fluentd w/ Sumologic and systemd plugins
COPY fluent.conf /fluentd/etc/fluent.conf.tmpl

ENV BUILD_VERSION 1.19.0-debian-2.1-stresstest-1
