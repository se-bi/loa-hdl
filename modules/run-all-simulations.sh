#!/bin/bash

set -eux

for i in */
do
  if [ -d $i/tb ]
  then
    echo "Module $i"
    pushd $i/tb

    make run

    popd
  fi
done
