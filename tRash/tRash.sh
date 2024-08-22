#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Components.
cR="$dR/trash.log"
# Entry directory.
eR="$dR/Trash"
# Aliases.
alias tRash="tR"


# tRash shred function.
tR_shred() {
  for target in "$eR"/{.,}*; do
    if [ "$(basename "$target")" != ".gitkeep" ]; then
      rm -rf $target
    fi
  done
  rm "$cR"
  touch "$cR"
}


# tRash recover function.
tR_recover() {
  if [ -f "$cR" ]; then
    while IFS=':' read -r target path; do
      if [ -f "$path" ] || [ -d "$path" ]; then
        echo "$fSERROR  ${sHL}$path${sRESET} already exists. Skipping..."
      elif [ -f "$eR/$target" ] || [ -d "$eR/$target" ]; then
        echo "$fSOK  Restoring ${sHL}$target${sRESET}..."
        mv "$eR/$target" "$path"
      else
        echo "$fSERROR  ${sHL}$path${sRESET} missing. Skipping..."
      fi
    done < "$cR"
    rm "$cR"
    touch "$cR"
  else
    echo "$fEMPTY"
    echo "$fERROR Missing ${sBBLUE}tRash${sRESET} log file."
    echo "$fBODY  Building new log file..."
    touch "$cR"
    echo "$fEMPTY"
    echo "$fTIP If issue persists,"
    echo "$fBODY  you may wish to perform a full reinstall."
  fi
}


# tRash toss function.
tR_toss() {
  target=$(realpath "$1")
  targetBase=$(basename "$1")
  echo "$targetBase:$target" >> "$cR"
  tM -f "$1" "$eR"
}


# tRash help info.
tR_help() {
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tRash${sRESET}] A trash can for ${sBBLUE}bash${sRESET}."
  echo "$fUSE  ${sHL}tR${sRESET} (view contents)"
  echo "$fBODY  ${sHL}tR [target]${sRESET} (toss target)"
  echo "$fOPT  ${sHL}tR -r${sRESET} (recover all trash)"
  echo "$fBODY  ${sHL}tR --shred${sRESET} (delete all trash)"
}


# Callable function.
tR() {
  if [ -z "$1" ]; then
    tV -a "$eR"
  elif [ -f "$1" ] || [ -d "$1" ] ; then
    tR_toss "$@"
  elif [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    tR_help
  elif [ "$1" = "--recover" ] || [ "$1" = "-r" ]; then
    tR_recover
  elif [ "$1" = "--shred" ]; then
    tR_shred
  else
    tA_invalid_argument
  fi
}
