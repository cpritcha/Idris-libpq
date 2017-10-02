#!/usr/bin/env bash
set -u

LIBPQ_LOCATION=/usr/local/opt/libpq/lib
LIBPQ_INCLUDE=/usr/local/opt/libpq/include

gcc -L${LIBPQ_LOCATION} -I${LIBPQ_INCLUDE} -lpq testlibpq.c -o testlibpq
