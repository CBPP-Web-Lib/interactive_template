#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
source ./_compose.sh

# HOST_UID/HOST_GID, not UID/GID. UID is a bash builtin that many shells export,
# and Compose prefers the process environment over .env -- which silently yielded
# a mixed "uid from the shell, gid from .env" result, and on macOS defeated the
# root override below entirely.
HOST_UID=$(id -u)
HOST_GID=$(id -g)

# macOS: Docker Desktop maps container-root writes back to the invoking host
# user, so running as root avoids ownership churn rather than causing it.
if [[ "$(uname)" == "Darwin" ]]; then
  HOST_UID=0
  HOST_GID=0
fi

cp .env_custom .env
{
  echo ""
  echo "HOST_UID=${HOST_UID}"
  echo "HOST_GID=${HOST_GID}"
} >> .env

cp php.local.ini.example php.local.ini

# Two things this invocation has to get right:
#
# --rm must come BEFORE the service name. After it, Compose treats it as an
# argument to the command, so the container is never removed and npm actually
# runs as `npm install --rm`.
#
# HOME must be set explicitly. If your host uid has no matching /etc/passwd
# entry in the image (anything other than 1000 for node:*), HOME falls back to
# "/" and npm fails with EACCES trying to create its cache at /.npm.
"${COMPOSE[@]}" run --rm \
  -u "${HOST_UID}:${HOST_GID}" \
  -e HOME=/tmp \
  --workdir /opt/project/app \
  --entrypoint "npm install" \
  node-watch

echo
echo "Installed as ${HOST_UID}:${HOST_GID}. Run ./start.sh next."
