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


# Entry not found error.
tCr_entry_not_found() {
  echo "$fSERROR  ${sHL}$2${sRESET} ${sBYELLOW}craft${sRESET} not found."
}


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


# Shred all entries.
tCr_shred_entries() {
  for file in "$edCR"/*; do
    rm $file
  done
}


# Delete craft entry.
tCr_delete_entry() {
  if [ -z "$2" ]; then
    tA_too_few_arguments
  elif [ ! -f "$edCR/$2" ]; then
    echo "$fSERROR  No ${sBYELLOW}craft${sRESET} named ${sHL}$2${sRESET} found."
  else
    echo "$fSOK  Deleting ${sBYELLOW}$2${sRESET}..."
    rm "$edCR/$2"
  fi
}


# Edit ticket entry.
tCr_edit_entry() {
  if [ -z "$2" ]; then
    tA_too_few_arguments
  elif [ ! -f "$edCR/$2" ]; then
    echo "$fSERROR  No ${sBYELLOW}craft${sRESET} named ${sHL}$2${sRESET} found."
  else
    tE "$edCR/$2"
  fi
}


# View ticket entry.
tCr_view_entry() {
  echo "$fBODY3  ${sHL}$(cat "$edCR/$2")${sRESET}"
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
  echo "$fMARK [${sBYELLOW}tCraft${sRESET}] Add, edit, delete, and view custom aliases."
  echo "$fUSE  ${sHL}tCr${sRESET} (view all aliases)"
  echo "$fOPT  ${sHL}tCr -a \"[command]\"${sRESET} (add new alias)"
  echo "$fBODY  ${sHL}tCr -v [target]${sRESET} (view contents of target alias)"
  echo "$fBODY  ${sHL}tLi -e [target]${sRESET} (open target alias for editing)"
  echo "$fBODY  ${sHL}tCr -d [target]${sRESET} (delete target alias)"
  echo "$fBODY  ${sHL}tCr --shred${sRESET} (delete all aliases)"
  echo "$fEMPTY"
  echo "$fTIP ${sBYELLOW}tCraft${sRESET} allows you to create an alias from any command,"
  echo "$fBODY  extending ${sBCYAN}tAsty${sRESET}'s functionality"
  echo "$fBODY  in whatever direction you choose to take it."
  echo "$fEMPTY"
  echo "$fEXMPL ${sHL}tCr -a \"sudo apt update && sudo apt upgrade\"${sRESET}"
}


# Callable function.
tCr() {
  if [ "$1" = "--view" ] || [ "$1" = "-v" ] || [ -z "$1" ]; then
    if [ -z "$1" ] || [ -z "$2" ]; then
      tCr_view_entries
    elif [ -f "$edCR/$2" ]; then
      tCr_view_entry "$@"
    else
      tCr_entry_not_found "$@"
    fi
  elif [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    tCr_help
  elif [ "$1" = "--add" ] || [ "$1" = "-a" ]; then
    tCr_add_entry "$@"
  elif [ "$1" = "--edit" ] || [ "$1" = "-e" ]; then
    tCr_edit_entry "$@"
  elif [ "$1" = "--delete" ] || [ "$1" = "-d" ]; then
    tCr_delete_entry "$@"
  elif [ "$1" = "--shred" ]; then
    tCr_shred_entries
  else
    tA_invalid_argument
  fi
}

