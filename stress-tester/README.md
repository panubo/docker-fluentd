# Fluentd Stress Test (Debian Base)

This container uses the fluentd [dummy Input Plugin](https://docs.fluentd.org/v1.0/articles/in_dummy) to generate logs to stdout (much like any other container based application).

## Config

The following environmnet variables are used:

* `FLUENTD_DUMMY_RATE` - how many events to generate per second. (Default: `1`)

## Example usage

```
docker run --rm -i -e FLUENTD_DUMMY_RATE=20 panubo/fluentd:...
```
