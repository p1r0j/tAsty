#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Component directories.
dI="$dBO/tIcket"
dLI="$dBO/tLink"
dCR="$dBO/tCraft"
# Components.
cI="$dI/tIcket.sh"
cLI="$dLI/tLink.sh"
cCR="$dCR/tCraft.sh"
# Aliases.
alias tBook="tBo"


# Source available components.
if [ -f "$cI" ]; then
  source "$cI"
fi
if [ -f "$cLI" ]; then
  source "$cLI"
fi
if [ -f "$cCR" ]; then
  source "$cCR"
fi


# Remove target entry.
tBo_remove() {
  tI "$@"
  tLi "$@"
  tCr "$@"
}


# View all contents.
tBo_view() {
  tI "$@"
  tLi "$@"
  tCr "$@"
}


# Validate entry name.
tBo_validate_name() {
  echo "$fEMPTY"
  if [[ ${#1} -ge 3 && "$1" =~ ^[a-zA-Z0-9_]+$ ]]; then
    entryName="t$1"
    if [ -f "$edI/$entryName" ]; then
      echo "$fERROR A ${sBPINK}ticket${sRESET} with the name"
      echo "$fBODY  ${sHL}$entryName${sRESET} already exists."
      return 1
    elif [ -f "$edLI/$entryName" ]; then
      echo "$fERROR A ${sBGREEN}link${sRESET} with the name"
      echo "$fBODY  ${sHL}$entryName${sRESET} already exists."
      return 1
    elif [ -f "$edCR/$entryName" ]; then
      echo "$fERROR A ${sBYELLOW}craft${sRESET} with the name"
      echo "$fBODY  ${sHL}$entryName${sRESET} already exists."
      return 1
    else
      echo "$fOK Creating entry..."
      return 0
    fi
  else
    echo "$fERROR Name must contain at least three characters"
    echo "$fBODY  and contain no special characters."
    return 1
  fi
}


# Book help info.
tBo_help() {
  echo "$fEMPTY"
  echo "$fNEUTRAL ${sBBLUE}tBook${sRESET} is where your aliases created with"
  echo "$fBODY  ${sBPINK}tIcket${sRESET}, ${sBGREEN}tLink${sRESET}, and ${sBYELLOW}tCraft${sRESET}"
  echo "$fBODY  are stored."
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tBo${sRESET} to display your current aliases."
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tBo -v [target]${sRESET} to view contents of a specific entry,"
  echo "$fBODY  where ${sBBLUE}target${sRESET} is the name of a ${sBBLUE}tBook${sRESET} entry."
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tBo -r [target]${sRESET} to remove a specific entry,"
  echo "$fBODY  where ${sBBLUE}target${sRESET} is again the name of a ${sBBLUE}tBook${sRESET} entry."
}


# Callable function.
tBo() {
  if [ "$1" == "--help" ] || [ "$1" = "-h" ]; then
    tBo_help
  elif [ "$1" = "--view" ] || [ "$1" = "-v" ]; then
    tBo_view "$@"
  elif [ "$1" = "--remove" ] || [ "$1" = "-r" ]; then
    if [ -z "$2" ]; then
      tA_too_few_arguments
    else
      tBo_remove "$@"
    fi
  elif [ -z "$1" ]; then
    tBo_view "$@"
  else
    tA_invalid_argument
  fi
}

