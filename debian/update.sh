#!/usr/bin/env bash
# Update the Dockerfile to use the latest release

set -e

if [[ "$(uname -s)" == "Darwin" ]]; then
  osx_compat="g"
else
  osx_compat=""
fi

# Somewhat arbitrary filter to get us the latest image tag that has both arm64 and amd64 builds under the same tag
latest="$(skopeo inspect docker://docker.io/fluent/fluentd --override-arch arm64 --override-os linux | jq .RepoTags[] -r | grep 'debian-2.1' | sort -V | tail -n1)"

${osx_compat}sed -i -E -e "s/^FROM.*/FROM fluent\/fluentd:${latest}/" Dockerfile Dockerfile.update

docker build -f Dockerfile.update -t fluentd-gemfile-lock .
docker create --name fluentd-gemfile-lock fluentd-gemfile-lock
docker cp fluentd-gemfile-lock:/fluentd/Gemfile.lock ./Gemfile.lock
docker rm fluentd-gemfile-lock
