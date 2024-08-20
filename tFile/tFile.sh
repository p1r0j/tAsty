#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Aliases.
alias tFile="tFe"
alias tDelete="tD"


# tFile help info.
tFe_help() {
  echo "$fEMPTY"
  echo "$fNEUTRAL ${sBBLUE}tFile${sRESET} is a collection of file management tools,"
  echo "$fBODY  consisting of the following:"
  echo "$fEMPTY"
  echo "$fTALK [${sBCYAN}tDelete${sRESET}] Delete target file/directory."
  echo "$fUSE  ${sHL}tD [target]${sRESET}"
  echo "$fOPT  ${sHL}tD -f${sRESET} (force deletion with no confirmation)"
}


# tDelete callable function.
tD() {
  if [ -z "$1" ]; then
    tA_too_few_arguments
  elif [ "$1" = "--force" ] || [ "$1" = "-f" ]; then
    rm -rf "$2"
  elif [ -f "$1" ]; then
    rm "$1"
  elif [ -d "$1" ]; then
    rm -r "$1"
  else
    tA_invalid_argument
  fi
}


# Callable function.
tFe() {
  if [ "$1" == "--help" ] || [ "$1" = "-h" ]; then
    tFe_help
  elif [ -z "$1" ]; then
    tFe_help
  else
    tA_invalid_argument
  fi
}

