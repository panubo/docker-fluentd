# Docker images for Fluentd

Panubo's customised fluentd Docker images.

- [debian](debian/README.md) - Debian base for Systemd support.

**Unmaintained**

- [alpine](alpine/README.md) - Based on official optimised Alpine image.
- [stress-tester](stess-tester) - Fluentd image that continuously outputs log messages for testing logging systems.

## License

MIT License Volt Grid Pty Ltd.

# Fluentd (Debian Base)

This includes the following plugins:

- [Systemd](https://github.com/reevoo/fluent-plugin-systemd)
- [Amazon S3](https://github.com/fluent/fluent-plugin-s3)
- [CloudWatch Logs](https://github.com/fluent-plugins-nursery/fluent-plugin-cloudwatch-logs)
- [Google Cloud Logging](https://github.com/GoogleCloudPlatform/fluent-plugin-google-cloud)

## Systemd

Setting systemd [matches](https://github.com/reevoo/fluent-plugin-systemd/blob/master/docs/matching.md)

## Config

Mount your fluentd config files into the container at `/fluentd/etc/conf.d/*.conf` for fluentd to pick them up.

## Example Usage

```
docker run --rm -it --name fluentd -v $(pwd)/conf.d:/fluentd/etc/conf.d:ro -v $(pwd)/data:/home/fluent -v /var/log/journal:/var/log/journal:ro --security-opt label:disable --group-add 190 --user 1000 panubo/fluentd:1.11.1-debian
```
