#!/bin/bash
#
set -eufo pipefail

case "${1:-}" in
  slow) chayang -d 15;;
  fast) chayang -d 0.3;;
esac

exec swaylock -f -F
