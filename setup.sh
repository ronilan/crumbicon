#!/bin/sh
crumb_default="v0.0.5"
loaf_default="v0.0.1"
into=".tmp~inflate"

rm -rf $into # cleanup before start

build_and_clean() {
  command=$1
  exe=$2

  if $command;
  then
    printf "\e[32m%s build successful\e[0m\n" "$exe"
  else
    printf "\e[31m%s build failed\e[0m\n" "$exe"
    exit 1
  fi
    cd ..
    mv ./$into/"$exe" "$exe"
    rm -rf $into
}

run () {
  command=$1
  repo=$2
  checkout=$3
  exe=$4

  printf "\e[33mBuilding %s from branch/tag %s \e[0m \n" "$repo" "$checkout"
  if git clone -c advice.detachedHead=false --branch "$checkout" --depth 1 "$repo" "$into"
  then
    cd $into || exit
    build_and_clean "$command" "$exe"
  else
    printf "\e[31m%s is not valid version tag nor branch name nor SHA in %s\e[0m\n" "$checkout" "$repo"
  fi
}

run "gcc src/*.c -Wall -lm -o crumb" https://github.com/liam-ilan/crumb.git "${1:-$crumb_default}" "crumb"
run "../crumb loaf.crumb loaf.crumb loaf" https://github.com/liam-ilan/loaf.git "${2:-$loaf_default}" "loaf"
