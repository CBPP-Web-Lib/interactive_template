#!/bin/bash
set -euo pipefail

docker exec -w /opt/project/app $PROJECTID-watch \
  node --inspect=0.0.0.0:9229 "$1"
