#!/usr/bin/env sh

# Override official entrypoint to allow setting fluent group

uid=${FLUENT_UID:-1000}

# (re)add the fluent user with $FLUENT_UID
useradd -u ${uid} -o -c "" --no-create-home fluent
export HOME=/home/fluent

# chown home and data folder
chown -R fluent /home/fluent
chown -R fluent /fluentd

# give access to journal
groupadd -g 190 systemd-journal
usermod -a -G systemd-journal fluent

# set sumologic url
[ -z "${SUMOLOGIC_ENDPOINT}" ] && export SUMOLOGIC_ENDPOINT="https://${SUMOLOGIC_COLLECTOR_HOSTNAME}/receiver/v1/http/${SUMOLOGIC_URL_TOKEN}"

# Systemd config defaults
[ -z "${SYSTEMD_READ_FROM_HEAD}" ] && export SYSTEMD_READ_FROM_HEAD='true'

exec gosu fluent "$@"
