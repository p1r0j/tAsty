#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Component directories.
dN="$dRV/tNav"
# Components.
cN="$dN/tNav.sh"
# Aliases.
alias tRaveller="tRv"


# Source available components.
if [ -f "$cN" ]; then
  source "$cN"
fi


# tRaveller greeting.
tRv_greeting() {
  echo "$fEMPTY"
  echo "$fNEUTRAL Welcome back, ${sBCYAN}tRaveller${sRESET}."
}


# tRaveller help info.
tRv_help() {
  echo "$fEMPTY"
  echo "$fNEUTRAL ${sBBLUE}tRaveller${sRESET} is a collection of simple tools"
  echo "$fBODY  to make ${sBBLUE}bash${sRESET} usage more intuitive."
  echo "$fEMPTY"
  echo "$fTALK For help with specific components of ${sBBLUE}tRaveller${sRESET},"
  echo "$fBODY  try the following commands:"
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tN -h${sRESET} for ${sBBLUE}tNav${sRESET} help,"
  echo "$fBODY  a collection of navigational tools."
  echo "$fEMPTY"
  echo "$fUSAGE Or, ${sHL}tFe -h${sRESET} for ${sBBLUE}tFile${sRESET} help,"
  echo "$fBODY  a collection of file management tools."
}


# Callable function.
tRv() {
  if [ "$1" == "--help" ] || [ "$1" = "-h" ]; then
    tRv_help
  elif [ -z "$1" ]; then
    tRv_greeting
  else
    tA_invalid_argument
  fi
}

