#!/bin/sh
default="v0.0.1"
checkout=${1:-$default}
into=".tmp~crumb~inflate"

build_and_clean() {
  gcc src/*.c -Wall -lm -o crumb
  cd ..
  mv ./$into/crumb crumb
  rm -rf $into
}

if [ ${#checkout} = 40 ] # assumed to be a sha
then
  printf "\e[32mBuilding from SHA %s\e[0m\n" "$checkout"
  git clone https://github.com/liam-ilan/crumb.git $into
  cd $into || exit
  git reset --hard "$checkout"
  build_and_clean
  printf "\e[32mCrumb built successfully from %s\e[0m\n" "$checkout"
elif [ "$(printf '%s' "$checkout" | cut -c 1)" = "v" ] # its is a sha
then # assumed a version tag
  printf "\e[32mBuilding version %s \e[0m \n" "$checkout"
  git clone -c advice.detachedHead=false --branch "$checkout" --depth 1 https://github.com/liam-ilan/crumb.git $into
  cd $into || exit
  build_and_clean
  printf "\e[32mCrumb version %s built successfully\e[0m\n" "$checkout"
else
  printf "\e[31m%s not valid version tag nor SHA \e[0m\n" "$checkout"
fi
