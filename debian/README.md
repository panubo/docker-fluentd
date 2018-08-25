# Fluentd (Debian Base)

This includes the following plugins:

- [Sumologic](https://github.com/SumoLogic/fluentd-output-sumologic)
- [Systemd](https://github.com/reevoo/fluent-plugin-systemd)

## Environment Config

These environment configs will work with the sample configs:

- `SUMOLOGIC_ENDPOINT` - collector endpoint url, or specify `SUMOLOGIC_COLLECTOR_HOSTNAME` and `SUMOLOGIC_URL_TOKEN`
- `SUMOLOGIC_SOURCE_CATEGORY`
- `SYSTEMD_READ_FROM_HEAD` - default `true`
