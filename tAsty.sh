#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Joke.
poked=0
# Locator.
lDir="$( cd -- "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 ; pwd -P )"
# Main script.
sA="$lDir/tAsty.sh"
# Module directories.
dBO="$lDir/tBook"
dRV="$lDir/tRaveller"
dR="$lDir/tRash"
dP="$lDir/tPocket"
dCL="$lDir/tClip"
dNO="$lDir/tNote"
# Modules.
mBO="$dBO/tBook.sh"
mRV="$dRV/tRaveller.sh"
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
sHL=$(tput bold; tput setaf 4; tput setab 6)
sBOLD=$(tput bold)
sRESET=$(tput sgr0)
# Faces.
fINPUT="(${sBPINK}~[ ]~${sRESET})"
fNEUTRAL="[${sBCYAN}~'_'~${sRESET}]"
fTALK="[${sBCYAN}~'o'~${sRESET}]"
fHAPPY="[${sBCYAN}~'w'~${sRESET}]"
fSIGH="[${sBCYAN}~-.-~${sRESET}]"
fMONOCLE="[${sBCYAN}~p_-~${sRESET}]"
fANGRY="[${sBCYAN}~>-<~${sRESET}]"
fOUTPUT="[${sBGREEN}~!-!~${sRESET}]"
fOK="[${sBGREEN}~OK!~${sRESET}]"
fUSAGE="[${sBYELLOW}USAGE${sRESET}]"
fTIP="[${sBYELLOW}~TIP~${sRESET}]"
fEXMPL="[${sBYELLOW}EXMPL${sRESET}]"
fWARNG="[${sBYELLOW}WARNG${sRESET}]"
fERROR="[${sBRED}ERROR${sRESET}]"
fSOK=" |${sGREEN}OK!${sRESET}|"
fSERROR=" |${sRED}~!~${sRESET}|"
fBODY=" |${sCYAN}|  ${sRESET}|"
fBODY1=" |${sPINK}|  ${sRESET}|"
fBODY2=" |${sGREEN} | ${sRESET}|"
fBODY3=" |${sYELLOW}  |${sRESET}|"
fEMPTY=" |   |"
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
  echo "$fEMPTY"
  echo "$fNEUTRAL Welcome, ${sBCYAN}tRaveller${sRESET}."
  echo "$fBODY  Setting up tAsty is easy."
  echo "$fEMPTY"
  echo "$fTALK Simply paste the following line"
  echo "$fBODY  to your ${sHL}~/.bashrc${sRESET} file:"
  echo "$fEMPTY"
  echo "$fOUTPUT ${sHL}source \"$sA\"${sRESET}"
  echo "$fEMPTY"
  echo "$fTIP Once this is done,"
  echo "$fBODY  refresh your session"
  echo "$fBODY  (${sHL}source ~/.bashrc${sRESET})"
  echo "$fBODY  and tAsty should now be working."
  echo "$fEMPTY"
  echo "$fNEUTRAL Try running the command ${sHL}tA${sRESET}"
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
  echo "$fNEUTRAL ${sBCYAN}tAsty${sRESET} is an extension"
  echo "$fBODY  for your ${sHL}~/.bashrc${sRESET} file,"
  echo "$fBODY  consisting of the following modules:"
  echo "$fEMPTY"
  echo "$fTALK ${sBBLUE}tBook${sRESET}, ${sBBLUE}tRaveller${sRESET}, ${sBBLUE}tRash${sRESET},"
  echo "$fBODY  ${sBBLUE}tPocket${sRESET}, ${sBBLUE}tClip${sRESET}, and ${sBBLUE}tNote${sRESET}."
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tA -d${sRESET} to donate."
  echo "$fEMPTY"
  echo "$fTIP Learn more about any of ${sBCYAN}tAsty${sRESET}'s modules"
  echo "$fBODY  with the ${sHL}-h${sRESET} argument."
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
  elif [ -z "$1" ]; then
    if [ "$poked" = 3 ]; then
      echo "$fEMPTY"
      echo "$fANGRY What?!"
    elif [ "$poked" = 2 ]; then
      ((poked++))
      echo "$fEMPTY"
      echo "$fSIGH You're trying my patience..."
    elif [ "$poked" = 1 ]; then
      ((poked++))
      echo "$fEMPTY"
      echo "$fMONOCLE ... Yes?"
    elif [ "$poked" = 0 ]; then
      ((poked++))
      echo "$fEMPTY"
      echo "$fNEUTRAL Can I help you?"
    fi
  else
    tA_invalid_argument
  fi
}

