#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Aliases.
alias tFile="tFe"
alias tMake="tMa"
alias tMove="tM"
alias tCopy="tC"
alias tDelete="tD"
alias tWrite="tW"
alias tEdit="tE"
alias tReplace="tRp"
alias tSave="tSv"
alias tLoad="tL"


# tFile help info.
tFe_help() {
  echo "$fEMPTY"
  echo "$fNEUTRAL ${sBBLUE}tFile${sRESET} is a collection of file management tools,"
  echo "$fBODY  consisting of the following:"
  echo "$fEMPTY"
  echo "$fTALK [${sBCYAN}tMake${sRESET}] Create new file/directory."
  echo "$fUSE  ${sHL}tMa -[option] [name]${sRESET}"
  echo "$fOPT  ${sHL}tMa -f [name]${sRESET} (create new file)"
  echo "$fBODY  ${sHL}tMa -d [name]${sRESET} (create new directory)"
  echo "$fEMPTY"
  echo "$fNEUTRAL [${sBCYAN}tMove${sRESET}] Move target file/directory."
  echo "$fUSE  ${sHL}tM [target] [destination]${sRESET}"
  echo "$fOPT  ${sHL}tM -f${sRESET} (force move with no confirmation)"
  echo "$fEMPTY"
  echo "$fTALK [${sBCYAN}tCopy${sRESET}] Copy target file/directory."
  echo "$fUSE  ${sHL}tC [target] [destination]${sRESET}"
  echo "$fOPT  ${sHL}tC -f${sRESET} (force copy with no confirmation)"
  echo "$fEMPTY"
  echo "$fNEUTRAL [${sBCYAN}tDelete${sRESET}] Delete target file/directory."
  echo "$fUSE  ${sHL}tD [target]${sRESET}"
  echo "$fOPT  ${sHL}tD -f${sRESET} (force deletion with no confirmation)"
  echo "$fEMPTY"
  echo "$fTALK [${sBCYAN}tSave${sRESET}] Save copy of target using ${sBBLUE}rsync${sRESET}."
  echo "$fUSE  ${sHL}tSv [target]${sRESET} (save copy as [target].save)"
  echo "$fBODY  ${sHL}tSv [target] [name]${sRESET} (save copy as [name].save)"
  echo "$fEMPTY"
  echo "$fNEUTRAL [${sBCYAN}tLoad${sRESET}] Load saved copy of target using ${sBBLUE}rsync${sRESET}."
  echo "$fUSE  ${sHL}tL [target]${sRESET} (load [target].save as [target])"
  echo "$fBODY  ${sHL}tL [target] [name]${sRESET} (load [target].save as [name])"
  echo "$fEMPTY"
  echo "$fTALK [${sBCYAN}tWrite${sRESET}] Write to target file."
  echo "$fUSE  ${sHL}tW "[string]" [target]${sRESET} (append string to target)"
  echo "$fOPT  ${sHL}tW -r${sRESET} (replace target with string)"
  echo "$fEMPTY"
  echo "$fTIP ${sBBLUE}tWrite${sRESET} can be used to create new files"
  echo "$fBODY  using the ${sBBLUE}replace${sRESET} option."
  echo "$fBODY  With this option, the target will be"
  echo "$fBODY  created if it does not already exist."
  echo "$fEMPTY"
  echo "$fNEUTRAL [${sBCYAN}tEdit${sRESET}] Open file for editing."
  echo "$fUSE  ${sHL}tE [target]${sRESET}"
  echo "$fEMPTY"
  echo "$fTIP ${sBBLUE}tEdit${sRESET} uses your preferred ${sBBLUE}EDITOR${sRESET}"
  echo "$fBODY  (generally defined in your ${sHL}~/.bashrc${sRESET} file)."
  echo "$fBODY  Otherwise, it will default to ${sBBLUE}vim${sRESET}."
  echo "$fEMPTY"
  echo "$fTALK [${sBCYAN}tReplace${sRESET}] Replace specified strings in a target file."
  echo "$fUSE  ${sHL}tRp [target] \"[search phrase]\" \"[replacement phrase]\"${sRESET}"
  echo "$fEMPTY"
  echo "$fTIP ${sBBLUE}tReplace${sRESET} will ignore lines containing the safeword,"
  echo "$fBODY  ${sHL}wHiskey${sRESET} (caps sensitive)."
}


# tLoad callable function.
tL() {
  if [ -z "$1" ]; then
    tA_too_few_arguments
  elif [ -f "$1.save" ] || [ -d "$1.save" ]; then
    if [ -z "$2" ]; then
      if [ -d "$1.save" ]; then
        rsync -ar --delete "$1.save/" "$1/"
      elif [ -f "$1.save" ]; then
        rsync -a --delete "$1.save" "$1"
      else
        tA_invalid_argument
      fi
    else
      if [ -d "$1.save" ]; then
        rsync -ar --delete "$1.save/" "$2/"
      elif [ -f "$1.save" ]; then
        rsync -a --delete "$1.save" "$2"
      else
        tA_invalid_argument
      fi
    fi
  else
    tA_invalid_argument
  fi
}


# tSave callable function.
tSv() {
  if [ -z "$1" ]; then
    tA_too_few_arguments
  elif [ -f "$1" ] || [ -d "$1" ]; then
    if [ -z "$2" ]; then
      if [ -d "$1" ]; then
        rsync -ar --delete "$1/" "$1.save/"
      elif [ -f "$1" ]; then
        rsync -a --delete "$1" "$1.save"
      else
        tA_invalid_argument
      fi
    else
      if [ -d "$1" ]; then
        rsync -ar --delete "$1/" "$2.save/"
      elif [ -f "$1" ]; then
        rsync -a --delete "$1" "$2.save"
      else
        tA_invalid_argument
      fi
    fi
  else
    tA_invalid_argument
  fi
}


# tReplace callable function.
tRp() {
  if [ -z "$3" ]; then
    tA_too_few_arguments
  elif [ -f "$1" ]; then
    lineNumber=0
    tempFile="$1.temp"
    while IFS= read -r line; do
      ((lineNumber++))
      originalLine="$line"
      safeword="False"
      if [[ $line = *"wHiskey"* ]]; then
        safeword="True"
      fi
      if [ "$safeword" = "False" ]; then
        line="${line//"$2"/"$3"}"
      else
        if [ $(echo -n "$lineNumber" | wc -c) -eq 1 ]; then
          choice="  $lineNumber"
        elif [ $(echo -n "$lineNumber" | wc -c) -eq 2 ]; then
          choice=" $lineNumber"
        else
          choice="$lineNumber"
        fi
        echo " |${sCYAN}$choice${sRESET}|  ${sBBLUE}Safeword${sRESET} identified. Skipping..."
      fi
      if [ "$line" != "$originalLine" ]; then
        if [ $(echo -n "$lineNumber" | wc -c) -eq 1 ]; then
          choice="  $lineNumber"
        elif [ $(echo -n "$lineNumber" | wc -c) -eq 2 ]; then
          choice=" $lineNumber"
        else
          choice="$lineNumber"
        fi
        echo " |${sCYAN}$choice${sRESET}|  ${sHL}$line${sRESET}"
      fi
      echo "$line" >> "$tempFile"
    done < "$1"
    mv "$tempFile" "$1"
  else
    tA_invalid_argument
  fi
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


# tMake callable function.
tMa() {
  if [ -z "$2" ]; then
    tA_too_few_arguments
  elif [ "$1" = "--file" ] || [ "$1" = "-f" ]; then
    if [ ! -f "$2" ] && [ ! -d "$2" ]; then
      touch "$2"
    else
      echo "$fEMPTY"
      echo "$fERROR ${sHL}$2${sRESET} already exists."
    fi
  elif [ "$1" = "--directory" ] || [ "$1" = "-d" ]; then
    if [ ! -f "$2" ] && [ ! -d "$2" ]; then
      mkdir "$2"
    else
      echo "$fEMPTY"
      echo "$fERROR ${sHL}$2${sRESET} already exists."
    fi
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

