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
    newLink="alias $linkName=\"rsync -varu \"$1\" \"$2\" && rsync -varu \"$2\" \"$1\"\""
    echo "$newLink" > "$edLI/$linkName"
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
  echo "$fNEUTRAL ${sBGREEN}tLink${sRESET} is used to create rsync aliases,"
  echo "$fBODY  effectively allowing you to sync two targets"
  echo "$fBODY  both ways with a single command."
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tLi [target1] [target2]${sRESET}"
  echo "$fBODY  where ${sBBLUE}target1${sRESET} or ${sBBLUE}target2${sRESET}"
  echo "$fBODY  can be remote (${sHL}hostname:path/to/target/${sRESET})"
  echo "$fBODY  or local (${sHL}path/to/target/${sRESET})."
  echo "$fEMPTY"
  echo "$fWARNG ${sBGREEN}tLink${sRESET} will not delete files from either target."
  echo "$fBODY  If you want this behavior, use ${sBYELLOW}tCraft${sRESET} instead."
  echo "$fEMPTY"
  echo "$fTIP Only one or the other (${sBBLUE}target1${sRESET} or ${sBBLUE}target2${sRESET})"
  echo "$fBODY  can be remote--you can't link two remote targets."
  echo "$fEMPTY"
  echo "$fEXMPL ${sHL}tLi workPC:/home/tastyUser/Documents/ ~/Documents/${sRESET}"
}


# Callable function.
tLi() {
  if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    tLi_help
  elif [ "$1" = "--view" ] || [ "$1" = "-v" ]; then
    tLi_view_entries
  else
    echo "$fEMPTY"
    echo "$fWARNG ${sBGREEN}tLink${sRESET} will not validate either target for you."
    echo "$fBODY  Type carefully!"
    tLi_add_entry "$@"
  fi
}

