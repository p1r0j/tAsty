#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Component directories.
dV="$dRV/tView"
dB="$dRV/tBack"
# Components.
cVLS="$dV/ls.cache"
cVCAT="$dV/cat.cache"
cB="$dB/cache"
# Switches.
tV_mode="None"
# Aliases.
alias tRaveller="tRv"
alias tView="tV"
alias tNav="tN"
alias tUp="tU"
alias tBack="tB"
alias tFresh="tFs"


# tBack navigate function.
tB_navigate() {
  previousDir="$(pwd)"
  cd "$(cat $cB)"
  echo "$previousDir" > "$cB"
}


# tBack caching function.
tB_cache() {
  previousDir="$(pwd)"
  echo "$previousDir" > "$cB"
}


# Navigate function.
tN_navigate() {
  tB_cache
  cd "$1"
}


# tView file function.
tV_file() {
  oldIFS=$IFS
  IFS=$'\n'
  counter=0
  if [ -f "$cVCAT" ]; then
    rm "$cVCAT"
  fi
  while IFS= read -r line || [ -n "$line" ]; do
    ((counter++))
    if [ $(echo -n "$counter" | wc -c) -eq 1 ]; then
      choice="  $counter"
    elif [ $(echo -n "$counter" | wc -c) -eq 2 ]; then 
      choice=" $counter"
    else
      choice="$counter"
    fi
    echo " |${sPINK}$choice${sRESET}|  ${sHL}$line${sRESET}"
  done < "$1"
	cat "$1" | nl -ba -w1 -s" " > "$cVCAT"
  IFS=$oldIFS
}


# tView directory function.
tV_directory() {
  oldIFS=$IFS
  IFS=$'\n'
  counter=0
  if [ -f "$cVLS" ]; then
    rm "$cVLS"
  fi
  if [ "$tV_mode" = "Current" ]; then
    lsRaw=$(ls -hl --color=always --group-directories-first)
    lsTrim=$(echo "$lsRaw" | tail -n +2)
  elif [ "$tV_mode" = "Target" ]; then
    lsRaw=$(ls -hl --color=always --group-directories-first "$1")
    lsTrim=$(echo "$lsRaw" | tail -n +2)
  elif [ "$tV_mode" = "All Current" ]; then
    lsRaw=$(ls -ahl --color=always --group-directories-first)
    lsTrim=$(echo "$lsRaw" | tail -n +4)
  elif [ "$tV_mode" = "All Target" ]; then
    lsRaw=$(ls -ahl --color=always --group-directories-first "$2")
    lsTrim=$(echo "$lsRaw" | tail -n +4)
  fi
  for line in $lsTrim; do
    ((counter++))
    if [ $(echo -n "$counter" | wc -c) -eq 1 ]; then
      choice="  $counter"
    elif [ $(echo -n "$counter" | wc -c) -eq 2 ]; then
      choice=" $counter"
    else
      choice="$counter"
    fi
    echo " |${sPINK}$choice${sRESET}|  $line"
    lsName=$(awk '{$1=$2=$3=$4=$5=$6=$7=$8=""; print $0}' <<< "$line" | sed 's/^[[:space:]]*//')
    lsPath=$(realpath -q "$lsName")
    cleanLine=$(echo -n "$lsPath" | sed 's/\x1B\[[0-9;]*[JKmsu]//g')
    echo "$counter:$cleanLine" >> "$cVLS"
  done
  IFS=$oldIFS
}


# tRaveller greeting.
tRv_greeting() {
  echo "$fEMPTY"
  echo "$fNEUTRAL Welcome back, ${sBCYAN}tRaveller${sRESET}."
}


# Navigate help info.
tRv_help() {
  echo "$fEMPTY"
  echo "$fNEUTRAL ${sBBLUE}tRaveller${sRESET} is a collection of navigational tools,"
  echo "$fBODY  consisting of the following:"
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tV${sRESET} for viewing the contents of"
  echo "$fBODY  your current working directory,"
  echo "$fBODY  or ${sHL}tV [target]${sRESET} for viewing the contents of"
  echo "$fBODY  a target file or directory."
  echo "$fEMPTY"
  echo "$fTIP Use the ${sHL}-a${sRESET} argument to include hidden files"
  echo "$fBODY  (when used without a target or when target is a directory)."
  echo "$fEMPTY"
  echo "$fTIP The ${sPINK}magenta${sRESET} numbers to the left"
  echo "$fBODY  of ${sBBLUE}tView${sRESET}'s output is for use"
  echo "$fBODY  with ${sBBLUE}tSelect${sRESET} and ${sBBLUE}tClip${sRESET}."
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tN${sRESET} for navigating to your home directory,"
  echo "$fBODY  or ${sHL}tN [target]${sRESET} for navigating to a target directory"
  echo "$fBODY  (the previous working directory will be saved for use with ${sBBLUE}tB${sRESET})."
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tU${sRESET} for moving up a single directory,"
  echo "$fBODY  or ${sHL}tU [amount]${sRESET} for moving up a specified number of directories"
  echo "$fBODY  (again, previous working directory saved for use with ${sBBLUE}tB${sRESET})."
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tB${sRESET} for moving back to the previous working directory."
  echo "$fEMPTY"
  echo "$fUSAGE ${sHL}tFs${sRESET} to quickly source your ${sHL}~/.bashrc${sRESET} file."
  echo "$fEMPTY"
  echo "$fTIP ${sHL}tFs${sRESET} is short for ${sBBLUE}tFresh${sRESET}."
  echo "$fBODY  Use this shortcut after making changes to your ${sBBLUE}tBook${sRESET}"
  echo "$fBODY  for your new aliases to become accessible"
  echo "$fBODY  without relaunching your shell."
}


# tFresh callable function.
tFs() {
  echo "$fEMPTY"
  echo "$fNEUTRAL ${sGREEN}Feelin' fresh${sRESET}."
  source ~/.bashrc
}


# tUp callable function.
tU() {
  if [ -z "$1" ]; then
    tB_cache
    cd ..
  elif [[ "$1" =~ ^[0-9]+$ ]]; then
    tB_cache
    for (( i=0; i<$1; i++ )); do
      cd ..
    done
  else
    tA_invalid_argument
  fi
}


# tBack callable function.
tB() {
  if [ ! -f "$cB" ]; then
    echo "$fEMPTY"
    echo "$fERROR Missing cache file."
  else
    tB_navigate
  fi
}


# tNav callable function.
tN() {
  if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    tN_help
  elif [ -z "$1" ]; then
    tN "$HOME"
  elif [ ! -d "$1" ]; then
    tA_invalid_argument
  else
    tN_navigate "$@"
  fi
}


# tView callable function.
tV() {
  if [ -z "$1" ]; then
    tV_mode="Current"
    tV_directory
  elif [ -d "$1" ]; then
    tV_mode="Target"
    tV_directory "$@"
  elif [ "$1" = "--all" ] || [ "$1" = "-a" ]; then
    if [ -z "$2" ]; then
      tV_mode="All Current"
      tV_directory
    elif [ -d "$2" ]; then
      tV_mode="All Target"
      tV_directory "$@"
    else
      tA_invalid_argument
    fi
  elif [ -f "$1" ]; then
    tV_file "$@"
  else
    tA_invalid_argument
  fi
}


# Callable function.
tRv() {
  if [ "$1" == "--help" ] || [ "$1" = "-h" ]; then
    tRv_help
  elif [ -z "$1" ]; then
    tRv_greeting
  else
    tA_invalid_argument
  fi
}

