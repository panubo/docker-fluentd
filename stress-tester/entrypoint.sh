#!/usr/bin/env bash

set -e

gomplate < /fluentd/etc/fluent.conf.tmpl > /fluentd/etc/fluent.conf

exec "${@}"
