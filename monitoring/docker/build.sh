#!/bin/sh

docker build -t jberny/katacoda-promql-grafana:latest -f Dockerfile.grafana ../assets/grafana
docker build -t jberny/katacoda-promql-prometheus:latest -f Dockerfile.prometheus ../assets/prometheus