#!/bin/bash

set -eux

for i in */
do
  # FIXME:
  if [ "$i" == "spw_node/" ]
  then
    echo "Skip this one, there is more refactoring necessary for the dependencies"
    continue
  fi

  if [ -d $i/tb ]
  then
    echo "Module $i"
    pushd $i/tb

    make run

    popd
  fi
done
