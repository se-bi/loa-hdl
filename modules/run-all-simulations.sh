#!/bin/bash

set -eux

for i in */
do
  echo "Module $i"
  pushd $i/tb

  make run

  popd
done
