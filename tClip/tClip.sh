#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Entry directory.
eCL="$dCL/Clipboard"
# Components.
cCL="$eCL/clip.cache"
# Switches.
clipMode="Copy"
pasteMode="Append"
# Aliases.
alias tClip="tCl"
alias tPaste="tPa"


# tClip copy function.
tCl_copy() {
  if [ "$clipMode" = "Copy" ]; then
    if [ -f "$cCL" ]; then
      rm "$cCL"
    fi
  else
    clipMode="Copy"
  fi
  while (( $# > 0 )); do
    targets="$1"
    while IFS= read -r line; do
      number=$(echo "$line" | cut -d ' ' -f 1)
      contents=$(echo "$line" | cut -d ' ' -f 2-)
      if [[ "$number" = "$targets" || \
      ( "$number" -ge "$(echo "$targets" | cut -d '-' -f 1)" && \
      "$number" -le "$(echo "$targets" | cut -d '-' -f 2)" ) ]]; then
        echo "$fCLIP  Clipping line $number..."
        echo "$contents" >> "$cCL"
      fi
    done < "$cVCAT"
    shift
  done
}


# tClip help info.
tCl_help(){
  echo "$fEMPTY"
  echo "$fMARK ${sBCYAN}tClip${sRESET} consists of two components:"
  echo "$fBODY  ${sBBLUE}tClip${sRESET} and ${sBBLUE}tPaste${sRESET}."
  echo "$fEMPTY"
  echo "$fMARK [${sBBLUE}tClip${sRESET}] A clipboard for ${sBBLUE}bash${sRESET}."
  echo "$fUSE  ${sHL}tCl${sRESET} (view clipboard contents)"
  echo "$fBODY  ${sHL}tCl [#-#]${sRESET} (replace clipboard with selection)"
  echo "$fOPT  ${sHL}tCl -a [#-#]${sRESET} (append clipboard with selection)"
  echo "$fBODY  ${sHL}tCl -e${sRESET} (open clipboard for editing)"
  echo "$fBODY  ${sHL}tCl --shred${sRESET} (clear clipboard)"
  echo "$fEMPTY"
  echo "$fMARK [${sBBLUE}tPaste${sRESET}] Paste clipboard contents to target."
  echo "$fUSE  ${sHL}tPa [target]${sRESET} (append clipboard to target)"
  echo "$fOPT  ${sHL}tPa -r [target]${sRESET} (replace target with clipboard)"
  echo "$fEMPTY"
  echo "$fTIP When using the ${sBBLUE}replace${sRESET} (-r) option,"
  echo "$fBODY  ${sBBLUE}tPaste${sRESET} will create a new file"
  echo "$fBODY  in the event that ${sBBLUE}target${sRESET} does not exist."
}


# tPaste callable function.
tPa() {
  if [ -f "$cCL" ]; then
    if [ -z "$1" ]; then
      tA_too_few_arguments
    elif [ "$1" = "--replace" ] || [ "$1" = "-r" ]; then
      cat "$cCL" > "$2"
    else
      if [ -f "$1" ]; then
        cat "$cCL" >> "$1"
      else
        tA_invalid_argument
      fi
    fi
  else
    echo "$fSERROR  ${sBBLUE}tClip${sRESET} is empty."
  fi
}


# Callable function.
tCl() {
  if [ -z "$1" ]; then
    if [ -f "$cCL" ]; then
      tV "$cCL"
    else
      echo "$fSERROR  ${sBBLUE}tClip${sRESET} is empty."
    fi
  elif [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    tCl_help
  elif [ "$1" = "--append" ] || [ "$1" = "-a" ]; then
    clipMode="Append"
    tCl_copy "$@"
  elif [ "$1" = "--edit" ] || [ "$1" = "-e" ]; then
    tE "$cCL"
  elif [ "$1" = "--shred" ]; then
    if [ -z "$cCL" ]; then
      echo "$fSERROR  ${sBBLUE}tClip${sRESET} is empty."
    else
      rm "$cCL"
    fi
  else
    tCl_copy "$@"
  fi
}
