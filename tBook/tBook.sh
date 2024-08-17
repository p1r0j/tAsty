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


# Validate entry name.
tBo_validate_name() {
  echo "$fEMPTY"
  if [[ ${#1} -ge 3 && "$1" =~ ^[a-zA-Z0-9_]+$ ]]; then
    entryName="t$1"
    if [ -f "$edI/$entryName" ]; then
      echo "$fERROR A ${sBPURP}ticket${sRESET} with the name"
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


# Callable function.
tBo() {
  echo "$fEMPTY"
  if [ -z "$1" ]; then
    echo "Coming soon..."
  elif [ "$1" == "--help" ] || [ "$1" = "-h" ]; then
    echo "Coming soon..."
  fi
}

