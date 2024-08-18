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


# Remove ticket entry.
tI_remove_entry() {
  if [ -z "$2" ]; then
    tA_too_few_arguments
  elif [ ! -f "$edI/$2" ]; then
    echo "$fEMPTY"
    echo "$fERROR ${sHL}$2${sRESET} is not a valid target."
  else
    echo "$fEMPTY"
    echo "$fOK Removing ${sBPURP}$2${sRESET}..."
    rm "$edI/$2"
  fi
}


# View ticket entries.
tI_view_entries() {
  for file in "$edI"/*; do
    echo "$fBODY1  ${sBPURP}$(basename "$file")${sRESET}"
  done
}


# Ticket help info.
tI_help() {
  echo "$fEMPTY"
  echo "$fNEUTRAL ${sBPURP}tIcket${sRESET} is used to add, remove, and view ${sBBLUE}cd${sRESET} aliases,"
  echo "$fBODY  which allow you to bookmark frequented local directories."
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tI -a [target]${sRESET} to add a new alias,"
  echo "$fBODY  where ${sBBLUE}target${sRESET} is a directory path."
  echo "$fEMPTY"
  echo "$fEXMPL ${sHL}tI -a ~/Documents/Work/Project/Notes/${sRESET}"
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tI -r [target]${sRESET} to remove an existing alias,"
  echo "$fBODY  where ${sBBLUE}target${sRESET} is the full alias name."
  echo "$fEMPTY"
  echo "$fEXMPL ${sHL}tI -r tWorkNotes${sRESET}"
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tI -v${sRESET} to view a list of existing aliases."
}


# Callable function.
tI() {
  if [ "$1" = "--view" ] || [ "$1" = "-v" ] || [ -z "$1" ]; then
    tI_view_entries
  elif [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    tI_help
  elif [ "$1" = "--remove" ] || [ "$1" = "-r" ]; then
    tI_remove_entry "$@"
  elif [ "$1" = "--add" ] || [ "$1" = "-a" ]; then
    tI_add_entry "$@"
  else
    tA_invalid_argument
  fi
}

