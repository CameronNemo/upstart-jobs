#!/bin/sh

set -e

prog="$(basename $0)"
template_file="template.conf"

function usage() {
	cat <<EOF
Usage: $prog [opts] [startup events]
	-n --name job name
	-d --desc job desc, defaults to name
	-u --up   start events
	-w --down stop events
EOF
}

function err() {
	test -z "$@" || echo $prog $@
	exit 1
}

function debug() {
	test -n "$DEBUG" || return
	echo $prog $@
}

while test "$#" -gt 0; do
	case "$1" in
		-n|--name)
			name="$2"
			shift 2
			;;
		-d|--desc)
			desc="$2"
			shift 2
			;;
		-u|--up)
			up="$2"
			shift 2
			;;
		-w|--down)
			down="$2"
			shift 2
			;;
		*)
			usage
			err
			;;
	esac
done

test -n "$name" || { usage; err; }
test -n "$desc" || desc="$name"
test -n "$up"	|| up="startup"
test -n "$down" || down="runlevel [06]"

cat "$template_file" | sed "s/template/${name}/g" | sed "s/${name}_desc/${desc}/g" | sed "s/startup/${up}/g" | sed "s/runlevel \[06\]/${down}/g"
