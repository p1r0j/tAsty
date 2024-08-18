#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Component directories.
dB="$dN/tBack"
# Components.
cB="$dB/cache"
# Aliases.
alias tBack="tB"
alias tNav="tN"


# tBack navigate function.
tB_navigate() {
  previousDir="$(pwd)"
  cd "$(cat $cB)"
  echo "$previousDir" > "$cB"
}


# tBack caching function.
tB_cache() {
  previousDir="$(pwd)"
  echo "$previousDir" > "$cB"
}


# tBack callable function.
tB() {
  if [ ! -f "$cB" ]; then
    echo "$fEMPTY"
    echo "$fERROR Missing cache file."
  else
    tB_navigate
  fi
}


# Navigate function.
tN_navigate() {
  tB_cache
  cd "$1"
}


# Callable function.
tN() {
  if [ ! -d "$1" ]; then
    tA_invalid_argument
  else
    tN_navigate "$@"
  fi
}
