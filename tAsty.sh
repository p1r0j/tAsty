#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Locator.
lDir="$( cd -- "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 ; pwd -P )"
# Main script.
sA="$lDir/tAsty.sh"
# Module directories.
dBO="$lDir/tBook"
dRV="$lDir/tRaveller"
dFE="$lDir/tFile"
dR="$lDir/tRash"
dP="$lDir/tPocket"
dCL="$lDir/tClip"
dNO="$lDir/tNote"
# Modules.
mBO="$dBO/tBook.sh"
mRV="$dRV/tRaveller.sh"
mFE="$dFE/tFile.sh"
mR="$dR/tRash.sh"
mP="$dP/tPocket.sh"
mCL="$dCL/tClip.sh"
mNO="$dNO/tNote.sh"
# Styles.
sBBLACK=$(tput bold; tput setaf 0)
sBLACK=$(tput setaf 0)
sBRED=$(tput bold; tput setaf 1)
sRED=$(tput setaf 1)
sBGREEN=$(tput bold; tput setaf 2)
sGREEN=$(tput setaf 2)
sBYELLOW=$(tput bold; tput setaf 3)
sYELLOW=$(tput setaf 3)
sBBLUE=$(tput bold; tput setaf 4)
sBLUE=$(tput setaf 4)
sBPINK=$(tput bold; tput setaf 5)
sPINK=$(tput setaf 5)
sBCYAN=$(tput bold; tput setaf 6)
sCYAN=$(tput setaf 6)
sBWHITE=$(tput bold; tput setaf 7)
sWHITE=$(tput setaf 7)
sHL=$(tput bold; tput setaf 0; tput setab 7)
sBOLD=$(tput bold)
sRESET=$(tput sgr0)
# Faces.
fINPUT="(${sBPINK}~[ ]~${sRESET})"
fNEUTRAL="[${sBCYAN}~'_'~${sRESET}]"
fMARK="[${sBCYAN}~>>>~${sRESET}]"
fHAPPY="[${sBCYAN}~'w'~${sRESET}]"
fSIGH="[${sBCYAN}~-.-~${sRESET}]"
fMONOCLE="[${sBCYAN}~p_-~${sRESET}]"
fANGRY="[${sBCYAN}~>-<~${sRESET}]"
fOUTPUT="[${sBGREEN}~!-!~${sRESET}]"
fOK="[${sBGREEN}~OK!~${sRESET}]"
fUSE=" |${sYELLOW}USE${sRESET}|"
fOPT=" |${sYELLOW}OPT${sRESET}|"
fTIP="[${sBYELLOW}~TIP~${sRESET}]"
fEXMPL="[${sBYELLOW}EXMPL${sRESET}]"
fWARNG="[${sBYELLOW}WARNG${sRESET}]"
fERROR="[${sBRED}ERROR${sRESET}]"
fSOK=" |${sGREEN}OK!${sRESET}|"
fCLIP=" |${sYELLOW}->-${sRESET}|"
fSERROR=" |${sRED}~!~${sRESET}|"
fBODY=" |${sCYAN}|  ${sRESET}|"
fBODY1=" |${sPINK}|  ${sRESET}|"
fBODY2=" |${sGREEN} | ${sRESET}|"
fBODY3=" |${sYELLOW}  |${sRESET}|"
fEMPTY=" |   |"
# Version.
tVer="1.0"
# Joke.
poked=0
# Aliases.
alias tAsty="tA"
# Enable tPrompt.
PROMPT_COMMAND="tPrompt"


# Source available modules.
if [ -f "$mBO" ]; then
  source "$mBO"
fi
if [ -f "$mRV" ]; then
  source "$mRV"
fi
if [ -f "$mFE" ]; then
  source "$mFE"
fi
if [ -f "$mR" ]; then
  source "$mR"
fi
if [ -f "$mP" ]; then
  source "$mP"
fi
if [ -f "$mCL" ]; then
  source "$mCL"
fi
if [ -f "$mNO" ]; then
  source "$mNO"
fi
# Setup info.
if [ "$1" = "--setup" ]; then
  rm "$eP/.gitkeep"
  rm "$eR/.gitkeep"
  echo "$fEMPTY"
  echo "$fMARK Welcome, ${sBCYAN}tRaveller${sRESET}."
  echo "$fBODY  Setting up tAsty is easy."
  echo "$fEMPTY"
  echo "$fMARK Simply paste the following line"
  echo "$fBODY  to your ${sHL}~/.bashrc${sRESET} file:"
  echo "$fEMPTY"
  echo "$fOUTPUT ${sHL}source \"$sA\"${sRESET}"
  echo "$fEMPTY"
  echo "$fTIP Once this is done,"
  echo "$fBODY  refresh your session"
  echo "$fBODY  (${sHL}source ~/.bashrc${sRESET})"
  echo "$fBODY  and tAsty should now be working."
  echo "$fEMPTY"
  echo "$fMARK Try running the command ${sHL}tA -h${sRESET}"
  echo "$fBODY  to get started if this is your first time,"
  echo "$fBODY  or if you need a refresher."
fi


# Invalid argument error.
tA_invalid_argument() {
  echo "$fEMPTY"
  echo "$fERROR Invalid argument."
}


# Invalid argument error.
tA_too_few_arguments() {
  echo "$fEMPTY"
  echo "$fERROR Too few arguments."
}


# Donate function.
tA_donate() {
  echo "$fEMPTY"
  echo "$fHAPPY Thank you so much! ${sBPINK}<3${sRESET}"
  xdg-open "https://buymeacoffee.com/piroj"
}


# tAsty help info.
tA_help() {
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tAsty${sRESET}] An extension for your \"~/.bashrc\" file."
  echo "$fOPT  ${sHL}tA -d${sRESET} (open donations link)"
  echo "$fBODY  ${sHL}tA --version${sRESET} (view version number)"
  echo "$fEMPTY"
  echo "$fMARK ${sBCYAN}tAsty${sRESET} consists of the following modules:"
  echo "$fBODY  ${sBBLUE}tBook${sRESET}, ${sBBLUE}tRaveller${sRESET}, ${sBBLUE}tFile${sRESET},"
  echo "$fBODY  ${sBBLUE}tRash${sRESET}, ${sBBLUE}tPocket${sRESET}, ${sBBLUE}tClip${sRESET},"
  echo "$fBODY  and ${sBBLUE}tNote${sRESET}."
  echo "$fEMPTY"
  echo "$fTIP Learn more about each of ${sBCYAN}tAsty${sRESET}'s modules"
  echo "$fBODY  with the \"-h\" option."
}


# Custom prompt.
tPrompt() {
  pName=$(whoami)
  pDir=$(pwd)
  pWidth=$(tput cols)
  pDivider=""
  for ((i = 1; i <= pWidth; i++)); do
      pDivider="${pDivider}-"
  done
  tPrompt="(\[${sBPINK}\]~[ ]~\[${sRESET}\]) "
  echo "$pDivider"
  echo "$fNEUTRAL ${sBCYAN}$pName${sRESET}@${sBGREEN}$(hostname)${sRESET}:${sHL}$pDir${sRESET}"
  echo " |${fTITLE}   ${sRESET}|  "
  PS1="$tPrompt"
}


# Callable function.
tA() {
  if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    tA_help
  elif [ "$1" = "--donate" ] || [ "$1" = "-d" ]; then
    tA_donate
  elif [ "$1" = "--version" ]; then
    echo "$fEMPTY"
    echo "$fMARK [${sBCYAN}v$tVer${sRESET}]"
  elif [ -z "$1" ]; then
    if [ "$poked" = 3 ]; then
      echo "$fEMPTY"
      echo "$fANGRY What?!"
    elif [ "$poked" = 2 ]; then
      ((poked++))
      echo "$fEMPTY"
      echo "$fSIGH Okay, now you're just trying my patience..."
    elif [ "$poked" = 1 ]; then
      ((poked++))
      echo "$fEMPTY"
      echo "$fMONOCLE ... If you need help, try ${sHL}-h${sRESET}."
    elif [ "$poked" = 0 ]; then
      ((poked++))
      echo "$fEMPTY"
      echo "$fNEUTRAL Can I help you?"
    fi
  else
    tA_invalid_argument
  fi
}

