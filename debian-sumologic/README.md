# Fluentd (Debian Base)

This includes the following plugins:

- [Systemd](https://github.com/reevoo/fluent-plugin-systemd)
- [Amazon S3](https://github.com/fluent/fluent-plugin-s3)
- [CloudWatch Logs](https://github.com/fluent-plugins-nursery/fluent-plugin-cloudwatch-logs)

## Systemd

Setting systemd [matches](https://github.com/reevoo/fluent-plugin-systemd/blob/master/docs/matching.md)

## Config

Mount your fluentd config files into the container at `/fluentd/etc/config.d/*.conf` for fluentd to pick them up.
