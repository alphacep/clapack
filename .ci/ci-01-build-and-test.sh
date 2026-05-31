#!/bin/bash
REPO_ROOT=$(realpath $(dirname ${BASH_SOURCE[0]})/..)
# TMPDIR="$(mktemp -d)"
# trap 'rm -rf "${TMPDIR}"' EXIT
TMPDIR=build-${VARIANT}
cmake \
    -DCMAKE_C_FLAGS=-fcommon `# gcc-14 seem to need fcommon for legacy COMMON block behaviour ` \
    -DCMAKE_GENERATOR=Ninja \
    -DCMAKE_C_COMPILER_LAUNCHER=ccache \
    -S $REPO_ROOT \
    -B $TMPDIR \
    --fresh
    
cmake --build $TMPDIR --parallel

# among the tests: xeigtstz puts very large doublecomplex arrays on the stack;
# with the default 8 MB stack it segfaults before writing output, hence we make
# the stack size unlimited:
ulimit -s unlimited
ctest --test-dir $TMPDIR --output-on-failure
