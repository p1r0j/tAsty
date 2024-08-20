#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Aliases.
alias tFile="tFe"


# tFile help info.
tFe_help() {
  echo "$fEMPTY"
  echo "$fNEUTRAL ${sBBLUE}tFile${sRESET} is a collection of file management tools,"
  echo "$fBODY  consisting of the following:"
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

