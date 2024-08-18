#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Component directories.
dB="$dN/tBack"
# Components.
cB="$dB/cache"
# Aliases.
alias tUp="tU"
alias tBack="tB"
alias tFresh="tFs"
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


# Navigate function.
tN_navigate() {
  tB_cache
  cd "$1"
}


# Navigate help info.
tN_help() {
  echo "$fEMPTY"
  echo "$fNEUTRAL ${sBBLUE}tNav${sRESET} is a collection of navigational tools,"
  echo "$fBODY  consisting of the following:"
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tN${sRESET} for navigating to your home directory,"
  echo "$fBODY  or ${sHL}tN [target]${sRESET} for navigating to a target directory"
  echo "$fBODY  (the previous working directory will be saved for use with ${sBBLUE}tB${sRESET})."
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tU${sRESET} for moving up a single directory,"
  echo "$fBODY  or ${sHL}tU [amount]${sRESET} for moving up a specified number of directories"
  echo "$fBODY  (again, previous working directory saved for use with ${sBBLUE}tB${sRESET})."
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tB${sRESET} for moving back to the previous working directory."
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tFs${sRESET} to quickly source your ${sHL}~/.bashrc${sRESET} file."
  echo "$fEMPTY"
  echo "$fTIP Use ${sHL}tFs${sRESET} after making changes to your ${sBBLUE}tBook${sRESET}"
  echo "$fBODY  for your new aliases to become accessible"
  echo "$fBODY  without relaunching your shell."
}


# tUp callable function.
tU() {
  if [ -z "$1" ]; then
    tB_cache
    cd ..
  elif [[ "$1" =~ ^[0-9]+$ ]]; then
    tB_cache
    for (( i=0; i<$1; i++ )); do
      cd ..
    done
  else
    tA_invalid_argument
  fi
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


# tFresh callable function.
tFs() {
  echo "$fEMPTY"
  echo "$fNEUTRAL ${sGREEN}Feelin' fresh${sRESET}."
  source ~/.bashrc
}


# Callable function.
tN() {
  if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    tN_help
  elif [ -z "$1" ]; then
    tN "$HOME"
  elif [ ! -d "$1" ]; then
    tA_invalid_argument
  else
    tN_navigate "$@"
  fi
}
