#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Aliases.
alias tFile="tFe"
alias tMove="tM"
alias tDelete="tD"


# tFile help info.
tFe_help() {
  echo "$fEMPTY"
  echo "$fNEUTRAL ${sBBLUE}tFile${sRESET} is a collection of file management tools,"
  echo "$fBODY  consisting of the following:"
  echo "$fEMPTY"
  echo "$fTALK [${sBCYAN}tMove${sRESET}] Move target file/directory."
  echo "$fUSE  ${sHL}tM [target] [destination]${sRESET}"
  echo "$fOPT  ${sHL}tM -f${sRESET} (force move with no confirmation)"
  echo "$fEMPTY"
  echo "$fNEUTRAL [${sBCYAN}tDelete${sRESET}] Delete target file/directory."
  echo "$fUSE  ${sHL}tD [target]${sRESET}"
  echo "$fOPT  ${sHL}tD -f${sRESET} (force deletion with no confirmation)"
}


# tDelete callable function.
tD() {
  if [ -z "$1" ]; then
    tA_too_few_arguments
  elif [ "$1" = "--force" ] || [ "$1" = "-f" ]; then
    if [ -z "$2" ]; then
      tA_too_few_arguments
    elif [ -f "$2" ] || [ -d "$2" ]; then
      rm -rf "$2"
    else
      tA_invalid_argument
    fi
  elif [ -f "$1" ]; then
    rm "$1"
  elif [ -d "$1" ]; then
    rm -r "$1"
  else
    tA_invalid_argument
  fi
}


# tMove callable function.
tM() {
  if [ -z "$2" ]; then
    tA_too_few_arguments
  elif [ "$1" = "--force" ] || [ "$1" = "-f" ]; then
    if [ -z "$3" ]; then
      tA_too_few_arguments
    elif [ -f "$2" ] || [ -d "$2" ]; then
      mv -f "$2" "$3"
    else
      tA_invalid_argument
    fi
  elif [ -f "$1" ] || [ -d "$1" ]; then
    mv "$1" "$2"
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

