#!/usr/bin/env bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/opt/libpq/lib
idris --build libpq.ipkg
