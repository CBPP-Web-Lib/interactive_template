#!/bin/bash
#
# Deploys to the Pantheon files directory, so the graphic is served from the main
# cbpp.org domain rather than apps.cbpp.org. Same-origin means no CORS headers to
# maintain and no separate host to keep alive.
#
# Public URL: https://www.cbpp.org/sites/default/files/interactives/$PROJECTID/
#
# Deploy to test first, then live:
#   PANTHEON_ENV=test ./deploy.sh
#   ./deploy.sh
#
# Note: Pantheon file directories are per-environment and do NOT propagate when
# code is deployed dev -> test -> live. Each environment must be pushed directly,
# and a content clone from live will overwrite whatever is in test.

set -euo pipefail

PANTHEON_ENV="${PANTHEON_ENV:-live}"
SITE_UUID="23aead92-ba4a-4ff5-95be-827c0e512757"
DEST="${PANTHEON_ENV}.${SITE_UUID}@appserver.${PANTHEON_ENV}.${SITE_UUID}.drush.in"

# --mkpath so the first deploy can create files/interactives/$PROJECTID/ itself.
RSYNC_OPTS=(-rlvz --ipv4 --mkpath --no-perms --exclude '.git' --exclude '.DS_Store')
SSH_OPTS='ssh -p 2222'

echo "Deploying $PROJECTID to Pantheon [$PANTHEON_ENV] ..."

rsync "${RSYNC_OPTS[@]}" \
  -e "$SSH_OPTS" \
  ./html/ "$DEST:files/interactives/$PROJECTID/"

rsync "${RSYNC_OPTS[@]}" \
  -e "$SSH_OPTS" \
  ./node/prod/ "$DEST:files/interactives/$PROJECTID/js/"

echo
echo "Done. Verify at:"
if [ "$PANTHEON_ENV" = "live" ]; then
  echo "  https://www.cbpp.org/sites/default/files/interactives/$PROJECTID/"
else
  echo "  https://${PANTHEON_ENV}-cbpp-2020.pantheonsite.io/sites/default/files/interactives/$PROJECTID/"
fi
