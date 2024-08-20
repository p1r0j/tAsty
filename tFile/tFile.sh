#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Aliases.
alias tFile="tFe"
alias tMove="tM"
alias tCopy="tC"
alias tDelete="tD"
alias tWrite="tW"
alias tEdit="tE"


# tFile help info.
tFe_help() {
  echo "$fEMPTY"
  echo "$fNEUTRAL ${sBBLUE}tFile${sRESET} is a collection of file management tools,"
  echo "$fBODY  consisting of the following:"
  echo "$fEMPTY"
  echo "$fTALK [${sBCYAN}tMove${sRESET}] Move target file/directory."
  echo "$fUSE  ${sHL}tM [target] [destination]${sRESET}"
  echo "$fOPT  ${sHL}tM -f${sRESET} (force move with no confirmation)"
  echo "$fEMPTY"
  echo "$fNEUTRAL [${sBCYAN}tCopy${sRESET}] Copy target file/directory."
  echo "$fUSE  ${sHL}tC [target] [destination]${sRESET}"
  echo "$fOPT  ${sHL}tC -f${sRESET} (force copy with no confirmation)"
  echo "$fEMPTY"
  echo "$fTALK [${sBCYAN}tDelete${sRESET}] Delete target file/directory."
  echo "$fUSE  ${sHL}tD [target]${sRESET}"
  echo "$fOPT  ${sHL}tD -f${sRESET} (force deletion with no confirmation)"
  echo "$fEMPTY"
  echo "$fNEUTRAL [${sBCYAN}tWrite${sRESET}] Write to target file."
  echo "$fUSE  ${sHL}tW "[string]" [target]${sRESET} (append string to target)"
  echo "$fOPT  ${sHL}tW -r${sRESET} (replace target with string)"
  echo "$fEMPTY"
  echo "$fTIP ${sBBLUE}tWrite${sRESET} can be used to create new files"
  echo "$fBODY  using the ${sBBLUE}replace${sRESET} option."
  echo "$fBODY  With this option, the target will be"
  echo "$fBODY  created if it does not already exist."
  echo "$fEMPTY"
  echo "$fTALK [${sBCYAN}tEdit${sRESET}] Open file for editing."
  echo "$fUSE  ${sHL}tE [target]${sRESET}"
  echo "$fEMPTY"
  echo "$fTIP ${sBBLUE}tEdit${sRESET} uses your preferred ${sBBLUE}EDITOR${sRESET}"
  echo "$fBODY  (generally defined in your ${sHL}~/.bashrc${sRESET} file)."
  echo "$fBODY  Otherwise, it will default to ${sBBLUE}vim${sRESET}."
}


# tEdit callable function.
tE() {
  if [ -z "$1" ]; then
    if [ -z "$EDITOR" ]; then
      vim
    else
      $EDITOR
    fi
  else
    if [ -z "$EDITOR" ]; then
      vim "$1"
    else
      $EDITOR "$1"
    fi
  fi
}


# tWrite callable function.
tW() {
  if [ -z "$2" ]; then
    tA_too_few_arguments
  elif [ "$1" = "--replace" ] || [ "$1" = "-r" ]; then
    if [ -z "$3" ]; then
      tA_too_few_arguments
    else
      echo "$2" > "$3"
    fi
  elif [ -f "$2" ]; then
    echo "$1" >> "$2"
  else
    tA_invalid_argument
  fi
}


# tDelete callable function.
tD() {
  if [ -z "$1" ]; then
    tA_too_few_arguments
  elif [ "$1" = "--force" ] || [ "$1" = "-f" ]; then
    if [ -z "$2" ]; then
      tA_too_few_arguments
    elif [ -f "$2" ] || [ -d "$2" ]; then
      rm -rf "$2"
    else
      tA_invalid_argument
    fi
  elif [ -f "$1" ]; then
    rm "$1"
  elif [ -d "$1" ]; then
    rm -r "$1"
  else
    tA_invalid_argument
  fi
}


# tCopy callable function.
tC() {
  if [ -z "$2" ]; then
    tA_too_few_arguments
  elif [ "$1" = "--force" ] || [ "$1" = "-f" ]; then
    if [ -z "$3" ]; then
      tA_too_few_arguments
    elif [ -f "$2" ] || [ -d "$2" ]; then
      cp -rf "$2" "$3"
    else
      tA_invalid_argument
    fi
  elif [ -f "$1" ]; then
    cp "$1" "$2"
  elif [ -d "$1" ]; then
    cp -r "$1" "$2"
  else
    tA_invalid_argument
  fi
}


# tMove callable function.
tM() {
  if [ -z "$2" ]; then
    tA_too_few_arguments
  elif [ "$1" = "--force" ] || [ "$1" = "-f" ]; then
    if [ -z "$3" ]; then
      tA_too_few_arguments
    elif [ -f "$2" ] || [ -d "$2" ]; then
      mv -f "$2" "$3"
    else
      tA_invalid_argument
    fi
  elif [ -f "$1" ] || [ -d "$1" ]; then
    mv "$1" "$2"
  else
    tA_invalid_argument
  fi
}


# Callable function.
tFe() {
  if [ "$1" == "--help" ] || [ "$1" = "-h" ]; then
    tFe_help
  elif [ -z "$1" ]; then
    tFe_help
  else
    tA_invalid_argument
  fi
}

