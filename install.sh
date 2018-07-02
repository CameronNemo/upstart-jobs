#!/bin/sh

set -e

SRCDIR=$1

test -n "$SRCDIR" || SRCDIR="INSTALL.minimal"
test -d "$SRCDIR" || exit 2

install -o root -g root -d "$DESTDIR"/etc/init/

for job in $(find "$SRCDIR" -name '*.conf'); do
	install -m 644 -o root -g root "$job" -t "$DESTDIR"/etc/init/
done
