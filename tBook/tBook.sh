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


# Shred all entries.
tBo_shred_entries() {
  tI "--shred"
  tLi "--shred"
  tCr "--shred"
}


# Remove target entry.
tBo_remove() {
  tI "$@"
  tLi "$@"
  tCr "$@"
}


# Edit target entry.
tBo_edit() {
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
  echo "$fTALK [${sBCYAN}tBook${sRESET}] View, edit, and remove custom aliases using"
  echo "$fBODY  ${sBPINK}tIcket${sRESET}, ${sBGREEN}tLink${sRESET}, and ${sBYELLOW}tCraft${sRESET}."
  echo "$fUSE  ${sHL}tBo${sRESET} (view all aliases)"
  echo "$fOPT  ${sHL}tBo -v [target]${sRESET} (view contents of target alias)"
  echo "$fBODY  ${sHL}tBo -e [target]${sRESET} (open target alias for editing)"
  echo "$fBODY  ${sHL}tBo -r [target]${sRESET} (remove target alias)"
  echo "$fBODY  ${sHL}tBo --shred${sRESET} (remove all aliases)"
  echo "$fEMPTY"
  echo "$fTIP See help info for"
  echo "$fBODY  ${sBPINK}tIcket${sRESET}, ${sBGREEN}tLink${sRESET}, and ${sBYELLOW}tCraft${sRESET}"
  echo "$fBODY  for how to add entries to your ${sBBLUE}tBook${sRESET}."
}


# Callable function.
tBo() {
  if [ "$1" == "--help" ] || [ "$1" = "-h" ]; then
    tBo_help
  elif [ "$1" = "--view" ] || [ "$1" = "-v" ]; then
    tBo_view "$@"
  elif [ "$1" = "--edit" ] || [ "$1" = "-e" ]; then
    if [ -z "$2" ]; then
      tA_too_few_arguments
    else
      tBo_edit "$@"
    fi
  elif [ "$1" = "--remove" ] || [ "$1" = "-r" ]; then
    if [ -z "$2" ]; then
      tA_too_few_arguments
    else
      tBo_remove "$@"
    fi
  elif [ "$1" = "--shred" ]; then
    tBo_shred_entries
  elif [ -z "$1" ]; then
    tBo_view "$@"
  else
    tA_invalid_argument
  fi
}

