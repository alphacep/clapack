#!/bin/bash
.ci/ci-01-build-and-test.sh
CC=clang CFLAGS=-fsanitize=address VARIANT=asan .ci/ci-01-build-and-test.sh
