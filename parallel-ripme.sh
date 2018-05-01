#!/bin/bash

PTHREADS="4"
RIPMEPATH="$HOME/ripreddit"
JTHREADS="6"

cat list | parallel -j$PTHREADS "java -jar ripme.jar -l ${RIPMEPATH} \
-t ${JTHREADS} -u https://reddit.com/r/{}"
