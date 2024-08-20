#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Entry directory.
edLI="$dLI/Links"
# Aliases.
alias tLink="tLi"


# Source all links.
for file in "$edLI"/t*; do
  if [ -f "$file" ]; then
    source "$file"
  fi
done


# Entry not found error.
tLi_entry_not_found() {
  echo "$fSERROR  ${sHL}$2${sRESET} ${sBGREEN}link${sRESET} not found."
}


# Add link entry.
tLi_add_entry() {
  if [ -z "$3" ]; then
    tA_too_few_arguments
    return
  fi
  if [ ! -d "$edLI" ]; then
    mkdir "$edLI"
  fi
  echo "$fEMPTY"
  echo "$fWARNG ${sBGREEN}tLink${sRESET} will not validate either target for you."
  echo "$fBODY  Type carefully!"
  echo "$fEMPTY"
  read -p "$fINPUT Choose a name: t" linkName
  if tBo_validate_name "$linkName"; then
    linkName="t$linkName"
    touch "$edLI/$linkName"
    newLink="alias $linkName=\"unison \"$2\" \"$3\" -auto -batch\""
    echo "$newLink" > "$edLI/$linkName"
  fi
}


# Shred all entries.
tLi_shred_entries() {
  for file in "$edLI"/*; do
    rm $file
  done
}


# Remove link entry.
tLi_remove_entry() {
  if [ -z "$2" ]; then
    tA_too_few_arguments
  elif [ ! -f "$edLI/$2" ]; then
    echo "$fSERROR  No ${sBGREEN}link${sRESET} named ${sHL}$2${sRESET} found."
  else
    echo "$fSOK  Removing ${sBGREEN}$2${sRESET}..."
    rm "$edLI/$2"
  fi
}


# View ticket entry.
tLi_view_entry() {
  echo "$fBODY2  ${sHL}$(cat "$edLI/$2")${sRESET}"
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
  echo "$fNEUTRAL [${sBGREEN}tLink${sRESET}] Add, remove, and view ${sBBLUE}unison${sRESET} aliases."
  echo "$fUSE  ${sHL}tLi${sRESET} (view all aliases)"
  echo "$fOPT  ${sHL}tLi -a [target1] [target2]${sRESET} (add new alias)"
  echo "$fBODY  ${sHL}tLi -v [target]${sRESET} (view contents of target alias)"
  echo "$fBODY  ${sHL}tLi -r [target]${sRESET} (remove target alias)"
  echo "$fBODY  ${sHL}tLi --shred${sRESET} (remove all aliases)"
  echo "$fEMPTY"
  echo "$fTIP ${sBGREEN}tLinks${sRESET} sync two targets bidirectionally using ${sBBLUE}unison${sRESET}."
  echo "$fBODY  This is especially useful for linking"
  echo "$fBODY  a remote directory with a local one."
  echo "$fEMPTY"
  echo "$fTIP When adding new ${sBGREEN}tLinks${sRESET},"
  echo "$fBODY  remote targets should be written in the format:"
  echo "$fBODY  ${sHL}ssh://hostname//path/to/target/${sRESET}"
  echo "$fEMPTY"
  echo "$fEXMPL ${sHL}tLi -a ssh://workPC//home/tastyUser/Documents ~/Documents${sRESET}"
  echo "$fEMPTY"
  echo "$fWARNG You must use the ${sBGREEN}tLink${sRESET} for the sync to occur--"
  echo "$fBODY  this is not an automatic sync tool."
}


# Callable function.
tLi() {
  if [ "$1" = "--view" ] || [ "$1" = "-v" ] || [ -z "$1" ]; then
    if [ -z "$1" ] || [ -z "$2" ]; then
      tLi_view_entries
    elif [ -f "$edLI/$2" ]; then
      tLi_view_entry "$@"
    else
      tLi_entry_not_found "$@"
    fi
  elif [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    tLi_help
  elif [ "$1" = "--remove" ] || [ "$1" = "-r" ]; then
    tLi_remove_entry "$@"
  elif [ "$1" = "--add" ] || [ "$1" = "-a" ]; then
    tLi_add_entry "$@"
  elif [ "$1" = "--shred" ]; then
    tLi_shred_entries
  else
    tA_invalid_argument
  fi
}

