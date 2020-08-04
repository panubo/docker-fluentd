# Fluentd Stress Test (Debian Base)

This container uses the fluentd [dummy Input Plugin](https://docs.fluentd.org/v1.0/articles/in_dummy) to generate logs to stdout (much like any other container based application).

## Config

The following environmnet variables are used:

* `FLUENTD_DUMMY_RATE` - how many events to generate per second. (Default: `1`)


**Note:** Based on a small about of testing the dummy Input Plugin is not completly accurate so you should expect about 10-15% less log messages than what is configured with `FLUENTD_DUMMY_RATE` (Tested at `FLUENTD_DUMMY_RATE=200`)

## Example usage

### Docker host

```
docker run --rm -i -e FLUENTD_DUMMY_RATE=20 panubo/fluentd:...
```

### Kubernetes

```
kubectl run --image=docker.io/panubo/fluentd:1.3.3-debian-1.0-stresstest-1 logtest --env="FLUENTD_DUMMY_RATE=1" --labels="fluentd.panubo.io/include=true,fluentd.panubo.io/environment=test,fluentd.panubo.io/role=web"
```
