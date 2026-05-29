#!/bin/bash
REPO_ROOT=$(realpath $(dirname ${BASH_SOURCE[0]}))
TMPDIR="$(mktemp -d)"
trap 'rm -rf "${TMPDIR}"' EXIT
cmake -B $TMPDIR -S $REPO_ROOT
cmake --build $TMPDIR
