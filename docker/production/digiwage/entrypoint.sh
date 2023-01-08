#!/bin/bash
set -e

if [[ "$1" == "digiwage-cli" || "$1" == "digiwage-tx" || "$1" == "digiwaged" || "$1" == "test_digiwage" ]]; then
	mkdir -p "$DIGIWAGE_DATA"

	chown -h digiwage:digiwage /home/digiwage/.digiwage
	exec gosu digiwage "$@"
else
	exec "$@"
fi
