#!/bin/bash
REPO_ROOT=$(realpath $(dirname ${BASH_SOURCE[0]})/..)
# TMPDIR="$(mktemp -d)"
# trap 'rm -rf "${TMPDIR}"' EXIT
TMPDIR=build
cmake \
    -DCMAKE_C_FLAGS=-fcommon `# gcc-14 seem to need fcommon for legacy COMMON block behaviour ` \
    -DCMAKE_GENERATOR=Ninja \
    -DCMAKE_C_COMPILER_LAUNCHER=ccache \
    -S $REPO_ROOT \
    -B $TMPDIR \
    --fresh
    
cmake --build $TMPDIR --parallel
ctest --test-dir $TMPDIR --output-on-failure
