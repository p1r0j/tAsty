#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Entry directory.
edI="$dI/Tickets"
# Aliases.
alias tIcket="tI"


# Source all tickets.
for file in "$edI"/t*; do
  if [ -f "$file" ]; then
    source "$file"
  fi
done


# Entry not found error.
tI_entry_not_found() {
  echo "$fSERROR  ${sHL}$2${sRESET} ${sBPINK}ticket${sRESET} not found."
}


# Add ticket entry.
tI_add_entry() {
  if [ -z "$2" ]; then
    tA_too_few_arguments
    return
  elif [ ! -d "$2" ]; then
    echo "$fEMPTY"
    echo "$fERROR ${sHL}$2${sRESET} is not a valid target."
    return
  fi
  if [ ! -d "$edI" ]; then
    mkdir "$edI"
  fi
  echo "$fEMPTY"
  read -p "$fINPUT Choose a name: t" ticketName
  if tBo_validate_name "$ticketName"; then
    ticketName="t$ticketName"
    touch "$edI/$ticketName"
    newTicket="alias $ticketName=\"tN \"$2\"\""
    echo "$newTicket" > "$edI/$ticketName"
  fi
}


# Shred all entries.
tI_shred_entries() {
  for file in "$edI"/*; do
    rm $file
  done
}


# Remove ticket entry.
tI_remove_entry() {
  if [ -z "$2" ]; then
    tA_too_few_arguments
  elif [ ! -f "$edI/$2" ]; then
    echo "$fSERROR  No ${sBPINK}ticket${sRESET} named ${sHL}$2${sRESET} found."
  else
    echo "$fSOK  Removing ${sBPINK}$2${sRESET}..."
    rm "$edI/$2"
  fi
}


# View ticket entry.
tI_view_entry() {
  echo "$fBODY1  ${sHL}$(cat "$edI/$2")${sRESET}"
}


# View ticket entries.
tI_view_entries() {
  for file in "$edI"/*; do
    echo "$fBODY1  ${sBPINK}$(basename "$file")${sRESET}"
  done
}


# Ticket help info.
tI_help() {
  echo "$fEMPTY"
  echo "$fNEUTRAL [${sBPINK}tIcket${sRESET}] Add, remove, and view ${sBBLUE}cd${sRESET} aliases."
  echo "$fUSE  ${sHL}tI${sRESET} (view all aliases)"
  echo "$fOPT  ${sHL}tI -a [path/to/target]${sRESET} (add new alias)"
  echo "$fBODY  ${sHL}tI -v [target]${sRESET} (view contents of target alias)"
  echo "$fBODY  ${sHL}tI -r [target]${sRESET} (remove target alias)"
  echo "$fBODY  ${sHL}tI --shred${sRESET} (remove all aliases)"
  echo "$fEMPTY"
  echo "$fTIP ${sBPINK}tIckets${sRESET} are like bookmarks,"
  echo "$fBODY  used to quickly travel to frequented"
  echo "$fBODY  locations within your local file system."
  echo "$fEMPTY"
  echo "$fEXMPL ${sHL}tI -a ~/Documents/Work/Project/Notes/${sRESET}"
}


# Callable function.
tI() {
  if [ "$1" = "--view" ] || [ "$1" = "-v" ] || [ -z "$1" ]; then
    if [ -z "$1" ] || [ -z "$2" ]; then
      tI_view_entries
    elif [ -f "$edI/$2" ]; then
      tI_view_entry "$@"
    else
      tI_entry_not_found "$@"
    fi
  elif [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    tI_help
  elif [ "$1" = "--remove" ] || [ "$1" = "-r" ]; then
    tI_remove_entry "$@"
  elif [ "$1" = "--add" ] || [ "$1" = "-a" ]; then
    tI_add_entry "$@"
  elif [ "$1" = "--shred" ]; then
    tI_shred_entries
  else
    tA_invalid_argument
  fi
}

