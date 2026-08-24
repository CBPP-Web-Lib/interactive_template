#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
source ./_compose.sh
"${COMPOSE[@]}" up
