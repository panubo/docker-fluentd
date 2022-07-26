#!/usr/bin/env bash
# Update the Dockerfile to use the latest release

set -e

if [[ "$(uname -s)" == "Darwin" ]]; then
  osx_compat="g"
fi

# Skip image upgrade since 1.15 uses ruby 3 which some gems don't yet support
# latest="$(skopeo inspect docker://docker.io/fluent/fluentd | jq .RepoTags[] -r | sort -V | grep 'debian-1' | tail -n1)"

# ${osx_compat}sed -i -E -e "s/^FROM.*/FROM fluent\/fluentd:${latest}/" Dockerfile Dockerfile.update

docker build -f Dockerfile.update -t fluentd-gemfile-lock .
docker create --name fluentd-gemfile-lock fluentd-gemfile-lock
docker cp fluentd-gemfile-lock:/fluentd/Gemfile.lock ./Gemfile.lock
docker rm fluentd-gemfile-lock
