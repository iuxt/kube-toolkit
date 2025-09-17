#!/bin/bash
set -euxo pipefail

docker build . -t registry.cn-hangzhou.aliyuncs.com/iuxt/network-test:2025-06-20
# docker push registry.cn-hangzhou.aliyuncs.com/iuxt/network-test:2025-06-20

