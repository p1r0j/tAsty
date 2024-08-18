#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Entry directory.
edLI="$dLI/Links"
# Aliases.
alias tLink="tLi"


# Source all links.
for file in "$edLI"/*; do
  if [ -f "$file" ]; then
    source "$file"
  fi
done


# Add link entry.
tLi_add_entry() {
  echo "$fEMPTY"
  read -p "$fINPUT Choose a name: t" linkName
  if tBo_validate_name "$linkName"; then
    linkName="t$linkName"
    touch "$edLI/$linkName"
    newLink="alias $linkName=\"unison \"$1\" \"$2\" -auto -batch\""
    echo "$newLink" > "$edLI/$linkName"
  fi
}


# Remove link entry.
tLi_remove_entry() {
  if [ -z "$2" ]; then
    echo "$fEMPTY"
    echo "$fERROR ${sBGREEN}tLink ${sBBLUE}remove entry${sRESET} requires a target."
  elif [ ! -f "$edLI/$2" ]; then
    echo "$fEMPTY"
    echo "$fERROR ${sHL}$2${sRESET} is not a valid target."
  else
    echo "$fEMPTY"
    echo "$fOK Removing ${sBGREEN}$2${sRESET}..."
    rm "$edLI/$2"
  fi
}


# View link entries.
tLi_view_entries() {
  for file in "$edLI"/*; do
    echo "$fBODY2  ${sBGREEN}$(basename "$file")${sRESET}"
  done
}


# Link help info.
tLi_help() {
  echo "$fEMPTY"
  echo "$fNEUTRAL ${sBGREEN}tLink${sRESET} is used to create ${sBBLUE}unison${sRESET} aliases,"
  echo "$fBODY  allowing you to sync two targets."
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tLi [target1] [target2]${sRESET}"
  echo "$fBODY  where ${sBBLUE}target1${sRESET} or ${sBBLUE}target2${sRESET}"
  echo "$fBODY  can be remote (${sHL}ssh://hostname//path/to/target${sRESET})"
  echo "$fBODY  or local (${sHL}path/to/target${sRESET})."
  echo "$fEMPTY"
  echo "$fTIP Only one or the other (${sBBLUE}target1${sRESET} or ${sBBLUE}target2${sRESET})"
  echo "$fBODY  can be remote--you can't link two remote targets."
  echo "$fEMPTY"
  echo "$fEXMPL ${sHL}tLi ssh://workPC//home/tastyUser/Documents ~/Documents${sRESET}"
}


# Callable function.
tLi() {
  if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    tLi_help
  elif [ "$1" = "--view" ] || [ "$1" = "-v" ] || [ -z "$1" ]; then
    tLi_view_entries
  elif [ "$1" = "--remove" ] || [ "$1" = "-r" ]; then
    tLi_remove_entry "$@"
  elif [ -z "$2" ]; then
    echo "$fEMPTY"
    echo "$fERROR Invalid argument."
  else
    echo "$fEMPTY"
    echo "$fWARNG ${sBGREEN}tLink${sRESET} will not validate either target for you."
    echo "$fBODY  Type carefully!"
    tLi_add_entry "$@"
  fi
}

