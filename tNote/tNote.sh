#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Entry directory.
eNO="$dNO/Notes"
# Aliases.
alias tNote="tNo"


# tNote help info.
tNo_help() {
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tNote${sRESET}] Convenient note-taking for ${sBBLUE}bash${sRESET}."
  echo "$fUSE  ${sHL}tNo${sRESET} (open default note for editing)"
  echo "$fBODY  ${sHL}tNo [target]${sRESET} (open specified note for editing)"
  echo "$fOPT  ${sHL}tNo -v${sRESET} (view list of notes)"
  echo "$fEMPTY"
  echo "$fEXMPL ${sHL}tNo test${sRESET} to open or create a \"test.notes\" file."
  echo "$fEMPTY"
  echo "$fTIP The default ${sBBLUE}tNote${sRESET} file is \"t.note\"."
}


# Callable function.
tNo() {
  if [ -z "$1" ]; then
    tE "$eNO/t.note"
  elif [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    tNo_help
  elif [ "$1" = "--view" ] || [ "$1" = "-v" ]; then
    tV -a "$eNO"
  else
    tE "$eNO/$1.note"
  fi
}
