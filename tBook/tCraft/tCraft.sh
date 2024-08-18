#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Entry directory.
edCR="$dCR/Crafts"
# Aliases.
alias tCraft="tCr"


# Source all crafts.
for file in "$edCR"/t*; do
  if [ -f "$file" ]; then
    source "$file"
  fi
done


# Add craft entry.
tCr_add_entry() {
  if [ -z "$2" ]; then
    tA_too_few_arguments
    return
  fi
  if [ ! -d "$edCR" ]; then
    mkdir "$edCR"
  fi
  echo "$fEMPTY"
  read -p "$fINPUT Choose a name: t" craftName
  if tBo_validate_name "$craftName"; then
    craftName="t$craftName"
    touch "$edCR/$craftName"
    newCraft="alias $craftName=\"$2\""
    echo "$newCraft" > "$edCR/$craftName"
  fi
}


# Remove craft entry.
tCr_remove_entry() {
  if [ -z "$2" ]; then
    tA_too_few_arguments
  elif [ ! -f "$edCR/$2" ]; then
    echo "$fEMPTY"
    echo "$fERROR ${sHL}$2${sRESET} is not a valid target."
  else
    echo "$fEMPTY"
    echo "$fOK Removing ${sBYELLOW}$2${sRESET}..."
    rm "$edCR/$2"
  fi
}


# View craft entries.
tCr_view_entries() {
  for file in "$edCR"/*; do
    echo "$fBODY3  ${sBYELLOW}$(basename "$file")${sRESET}"
  done
}


# Craft help info.
tCr_help() {
  echo "$fEMPTY"
  echo "$fNEUTRAL ${sBYELLOW}tCraft${sRESET} is used to add, remove, and view custom aliases,"
  echo "$fBODY  allowing you to bookmark any command you wish."
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tCr -a \"[command]\"${sRESET} to add a new alias."
  echo "$fEMPTY"
  echo "$fEXMPL ${sHL}tCr -a \"sudo apt update && sudo apt upgrade\"${sRESET}"
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tCr -r [target]${sRESET} to remove an existing alias,"
  echo "$fBODY  where ${sBBLUE}target${sRESET} is the full alias name."
  echo "$fEMPTY"
  echo "$fEXMPL ${sHL}tCr -r tUpdate${sRESET}"
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tCr -v${sRESET} to view a list of existing aliases."
}


# Callable function.
tCr() {
  if [ "$1" = "--view" ] || [ "$1" = "-v" ] || [ -z "$1" ]; then
    tCr_view_entries
  elif [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    tCr_help
  elif [ "$1" = "--remove" ] || [ "$1" = "-r" ]; then
    tCr_remove_entry "$@"
  elif [ "$1" = "--add" ] || [ "$1" = "-a" ]; then
    tCr_add_entry "$@"
  else
    tA_invalid_argument
  fi
}

