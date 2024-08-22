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
alias tSearch="tSr"
alias tFilter="tF"
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
    baseDir="."
  elif [ "$tV_mode" = "Target" ]; then
    lsRaw=$(ls -hl --color=always --group-directories-first "$1")
    lsTrim=$(echo "$lsRaw" | tail -n +2)
    baseDir="$1"
  elif [ "$tV_mode" = "All Current" ]; then
    lsRaw=$(ls -ahl --color=always --group-directories-first)
    lsTrim=$(echo "$lsRaw" | tail -n +4)
    baseDir="."
  elif [ "$tV_mode" = "All Target" ]; then
    lsRaw=$(ls -ahl --color=always --group-directories-first "$2")
    lsTrim=$(echo "$lsRaw" | tail -n +4)
    baseDir="$2"
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
    lsPath=$(realpath -q "$baseDir/$lsName")
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
  echo "$fMARK [${sBCYAN}tRaveller${sRESET}] A collection of navigational tools,"
  echo "$fBODY  consisting of the following:"
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tView${sRESET}] View contents of files/directories."
  echo "$fUSE  ${sHL}tV${sRESET} (view current working directory)"
  echo "$fBODY  ${sHL}tV [target]${sRESET} (view target file/directory)"
  echo "$fOPT  ${sHL}tV -a${sRESET} (view hidden files/directories)"
  echo "$fEMPTY"
  echo "$fTIP The ${sPINK}magenta${sRESET} numbers to the left"
  echo "$fBODY  of ${sBBLUE}tView${sRESET}'s output are for use"
  echo "$fBODY  with ${sBBLUE}tSelect${sRESET} and ${sBBLUE}tClip${sRESET}."
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tSearch${sRESET}] Search current working directory for keyword/phrase."
  echo "$fUSE  ${sHL}tSr \"[search phrase]\"${sRESET}"
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tFilter${sRESET}] Filter results of piped command via keyword/line number."
  echo "$fUSE  ${sHL}tF -[option] [keyword or number range (#-#)]${sRESET}"
  echo "$fOPT  ${sHL}tF -k${sRESET} (filter by keyword/phrase)"
  echo "$fBODY  ${sHL}tF -l${sRESET} (filter by line number)"
  echo "$fEMPTY"
  echo "$fTIP ${sBBLUE}tFilter${sRESET} is meant to be used in conjunction"
  echo "$fBODY  with other commands, such as ${sBBLUE}tView${sRESET},"
  echo "$fBODY  through the use of pipes (|)."
  echo "$fEMPTY"
  echo "$fEXMPL ${sHL}tV work.note | tF -k \"meeting\"${sRESET}"
  echo "$fEMPTY"
  echo "$fEXMPL ${sHL}tV work.note | tF -l 4-20${sRESET}"
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tNav${sRESET}] Navigate your file system."
  echo "$fUSE  ${sHL}tN${sRESET} (navigate to home directory)"
  echo "$fBODY  ${sHL}tN [target]${sRESET} (navigate to target directory)"
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tUp${sRESET}] Move up specified number of directories."
  echo "$fUSE  ${sHL}tU${sRESET} (move up single directory)"
  echo "$fBODY  ${sHL}tU [#]${sRESET} (move up specified number of directories)"
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tBack${sRESET}] Move back to previous working directory."
  echo "$fUSE  ${sHL}tB${sRESET}"
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tFresh${sRESET}] Quickly source your \"~/.bashrc\" file."
  echo "$fUSE  ${sHL}tFs${sRESET}"
  echo "$fEMPTY"
  echo "$fTIP Use this shortcut after making changes to your ${sBBLUE}tBook${sRESET}"
  echo "$fBODY  for your new aliases to become accessible"
  echo "$fBODY  without relaunching your shell."
}


# tFresh callable function.
tFs() {
  echo "$fEMPTY"
  echo "$fMARK ${sGREEN}Feelin' fresh${sRESET}."
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
  if [ -z "$1" ]; then
    tN "$HOME"
  elif [ ! -d "$1" ]; then
    tA_invalid_argument
  else
    tN_navigate "$@"
  fi
}


# tFilter callable function
tF() {
  if [ -z "$2" ]; then
    tA_too_few_arguments
  elif [ "$1" = "--line" ] || [ "$1" = "-l" ]; then
    if [[ $2 =~ ^[0-9]+-[0-9]+$ ]]; then
      startLine=$(echo "$2" | cut -d'-' -f1)
      endLine=$(echo "$2" | cut -d'-' -f2)
      sed -n "${startLine},${endLine}p"
    else
      tA_invalid_argument
    fi
  elif [ "$1" = "--keyword" ] || [ "$1" = "-k" ]; then
    grep -i --color=never "$2"
  fi
}


# tSearch callable function.
tSr() {
  if [ -z "$1" ]; then
    tA_too_few_arguments
  else
    searchPhrase="$1"
    currentFile=""
    echo "$fEMPTY"
    echo "$fMONOCLE Searching for ${sHL}$1${sRESET}..."
    while IFS= read -r file; do
      if [[ "$file" = *".git"* ]]; then
        continue
      fi
      if [[ $(file --mime-type -b "$file") = "application/octet-stream" ]]; then
        continue
      fi
      lineNumber=1
      while IFS= read -r line; do
        if [[ "$line" =~ $searchPhrase ]]; then
          if [ "$file" != "$currentFile" ]; then
            echo "$fEMPTY"
            echo "$fMARK ${sHL}$file${sRESET}"
            currentFile="$file"
          fi
          if [ $(echo -n "$lineNumber" | wc -c) -eq 1 ]; then
            choice="  $lineNumber"
          elif [ $(echo -n "$lineNumber" | wc -c) -eq 2 ]; then
            choice=" $lineNumber"
          else
            choice="$lineNumber"
          fi
          echo " |${sCYAN}$choice${sRESET}|  $line"
        fi
        ((lineNumber++))
      done < "$file"
    done < <(find "$(pwd)" -type f)
    return
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

