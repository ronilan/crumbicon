#!/bin/sh
default="v0.0.2"
checkout=${1:-$default}
into=".tmp~crumb~inflate"

build_and_clean() {

if gcc src/*.c -Wall -lm -o crumb;
then
  printf "\e[32mCrumb built successfully\e[0m\n"
else
  printf "\e[31mCrumb built failed\e[0m\n"
  exit 1
fi
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
elif [ "$(printf '%s' "$checkout" | cut -c 1)" = "v" ] # it is a tag
then # assumed a version tag
  printf "\e[32mBuilding version %s \e[0m \n" "$checkout"
  git clone -c advice.detachedHead=false --branch "$checkout" --depth 1 https://github.com/liam-ilan/crumb.git $into
  cd $into || exit
  build_and_clean
else ## try branch
  printf "\e[32mBuilding version %s \e[0m \n" "$checkout"
  if git clone -c advice.detachedHead=false --branch "$checkout" --depth 1 https://github.com/liam-ilan/crumb.git $into
  then
    cd $into || exit
    build_and_clean
  else
    printf "\e[31m%s not valid version tag nor branch name nor SHA \e[0m\n" "$checkout"
  fi
fi
