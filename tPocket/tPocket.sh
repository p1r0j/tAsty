#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Entry directory.
eP="$dP/Pocket"
# Aliases.
alias tPocket="tP"


# Shred pocket.
tP_shred() {
  for target in "$eP"/{.,}*; do
    if [ "$(basename "$target")" != ".gitkeep" ]; then
      rm -rf $target
    fi
  done
}


# tPocket help info.
tP_help() {
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tPocket${sRESET}] Copy frequently used files/directories"
  echo "$fBODY  to/from a convenient location."
  echo "$fUSE  ${sHL}tP${sRESET} (view contents)"
  echo "$fBODY  ${sHL}tP [target]${sRESET} (pocket copy of target)"
  echo "$fOPT  ${sHL}tP -c [target]${sRESET} (copy contents to target)"
  echo "$fBODY  ${sHL}tP --shred${sRESET} (delete all contents)"
}


# Callable function.
tP() {
  if [ -z "$1" ]; then
    tV -a "$eP"
  elif [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    tP_help
  elif [ "$1" = "--copy" ] || [ "$1" = "-c" ]; then
    if [ -z "$2" ]; then
      tA_too_few_arguments
    elif [ -d "$2" ]; then
      cp -rf "$eP/"* "$2"
    else
      tA_invalid_argument
    fi
  elif [ "$1" = "--shred" ]; then
    tP_shred
  elif [ -f "$1" ]; then
    cp -rf "$1" "$eP"
  elif [ -d "$1" ]; then
    cp -rf "$1" "$eP/$(basename "$1")"
  else
    tA_invalid_argument
  fi
}
