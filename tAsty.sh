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
dCL="$lDir/tClipboard"
dP="$lDir/tPocket"
dR="$lDir/tRash"
dRV="$lDir/tRaveller"
# Modules.
mBO="$dBO/tBook.sh"
mCL="$dCL/tClipboard.sh"
mP="$dP/tPocket.sh"
mR="$dR/tRash.sh"
mRV="$dRV/tRaveller.sh"
# Styles.
sBGREEN=$(tput bold; tput setaf 2)
sGREEN=$(tput setaf 2)
sBYELLOW=$(tput bold; tput setaf 3)
sYELLOW=$(tput setaf 3)
sBBLUE=$(tput bold; tput setaf 4)
sBLUE=$(tput setaf 4)
sBPURP=$(tput bold; tput setaf 5)
sPURP=$(tput setaf 5)
sBCYAN=$(tput bold; tput setaf 6)
sCYAN=$(tput setaf 6)
sBGREY=$(tput bold; tput setaf 7)
sGREY=$(tput setaf 7)
sBBLACK=$(tput bold; tput setaf 8)
sBLACK=$(tput setaf 8)
sBRED=$(tput bold; tput setaf 9)
sRED=$(tput setaf 9)
sHL=$(tput bold; tput setaf 0; tput setab 6)
sBOLD=$(tput bold)
sRESET=$(tput sgr0)
# Faces.
fINPUT="(${sBPURP}~[ ]~${sRESET})"
fNEUTRAL="[${sBCYAN}~'_'~${sRESET}]"
fTALK="[${sBCYAN}~'o'~${sRESET}]"
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
fBODY=" |${sCYAN}|  ${sRESET}|"
fBODY1=" |${sPURP}|  ${sRESET}|"
fBODY2=" |${sGREEN} | ${sRESET}|"
fBODY3=" |${sYELLOW}  |${sRESET}|"
fEMPTY=" |   |"
# Enable tPrompt.
PROMPT_COMMAND="tPrompt"
# Aliases.
alias tAsty="tA"


# Source available modules.
if [ -f "$mBO" ]; then
  source "$mBO"
fi
if [ -f "$mCL" ]; then
  source "$mCL"
fi
if [ -f "$mP" ]; then
  source "$mP"
fi
if [ -f "$mR" ]; then
  source "$mR"
fi
if [ -f "$mRV" ]; then
  source "$mRV"
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


# Custom prompt.
tPrompt() {
  pName=$(whoami)
  pDir=$(pwd)
  pWidth=$(tput cols)
  pDivider=""
  for ((i = 1; i <= pWidth; i++)); do
      pDivider="${pDivider}-"
  done
  tPrompt="(\[${sBPURP}\]~[ ]~\[${sRESET}\]) "
  echo "$pDivider"
  echo "$fNEUTRAL ${sBCYAN}$pName${sRESET}@${sBGREEN}$(hostname)${sRESET}:${sHL}$pDir${sRESET}"
  echo " |${fTITLE}   ${sRESET}|  "
  PS1="$tPrompt"
}


# Callable function.
tA() {
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
}

