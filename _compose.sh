# Sourced by the other scripts. Resolves the Compose CLI into $COMPOSE.
#
# Compose v2 ships as a `docker compose` subcommand; older installs have a
# standalone `docker-compose` binary. Current Docker Engine on Linux often has
# only the plugin, so hardcoding `docker-compose` fails there.

if docker compose version >/dev/null 2>&1; then
  COMPOSE=(docker compose)
elif command -v docker-compose >/dev/null 2>&1; then
  COMPOSE=(docker-compose)
else
  echo "Error: neither 'docker compose' nor 'docker-compose' is available." >&2
  echo "Install Docker (and make sure the daemon is running), then retry." >&2
  exit 1
fi
