#!/bin/bash

# Written by piroj
# for The Alias Supplement ThingY,
# tAsty.

# Component directories.
dS="$dFE/tSelect"
# Components.
cS="$dS/select.cache"
# Switches.
unlockMode="File"
# Aliases.
alias tFile="tFe"
alias tSelect="tS"
alias tMake="tMa"
alias tMove="tM"
alias tCopy="tC"
alias tDelete="tD"
alias tSave="tSv"
alias tLoad="tL"
alias tLock="tLc"
alias tUnlock="tUn"
alias tWrite="tW"
alias tEdit="tE"
alias tReplace="tRp"


# tSelect delete function.
tS_delete() {
  echo "$fEMPTY"
  read -p "$fINPUT Are you sure? (y/N) " answer
  answer=${answer,,}
  if [ "$answer" = "yes" ] || [ "$answer" = "y" ]; then
    while IFS= read -r target; do
      rm -rf "$target"
    done < "$cS"
  else
    echo "$fSERROR  Cancelling..."
  fi
}


# tSelect pocket function.
tS_pocket() {
  while IFS= read -r target; do
    tP "$target"
  done < "$cS"
}


# tSelect toss function.
tS_toss() {
  while IFS= read -r target; do
    tR "$target"
  done < "$cS"
}


# tSelect rename function.
tS_rename() {
  counter=0
  echo "$fEMPTY"
  read -p "$fINPUT Choose a name: #." name
  while IFS= read -r target; do
    ((counter++))
    targetDir="$(dirname "$target")"
    tM "-f" "$target" "$targetDir/$counter.$name"
  done < "$cS"
}


# tSelect copy function.
tS_copy() {
  echo "$fEMPTY"
  read -p "$fINPUT Choose a destination: " destination
  destination="${destination/#\~/$HOME}"
  while IFS= read -r target; do
    tC "-f" "$target" "$destination"
  done < "$cS"
}


# tSelect move function.
tS_move() {
  echo "$fEMPTY"
  read -p "$fINPUT Choose a destination: " destination
  destination="${destination/#\~/$HOME}"
  while IFS= read -r target; do
    tM "-f" "$target" "$destination"
  done < "$cS"
}


# tFile help info.
tFe_help() {
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tFile${sRESET}] A collection of file management tools,"
  echo "$fBODY  consisting of the following:"
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tSelect${sRESET}] Modify selection of files/directories."
  echo "$fUSE  ${sHL}tS -[option] [#-#]${sRESET} (modify single range)"
  echo "$fBODY  ${sHL}tS -[option] [#-#] [#-#]${sRESET} (modify multiple ranges)"
  echo "$fOPT  ${sHL}tS -m [#-#]${sRESET} (move selection)"
  echo "$fBODY  ${sHL}tS -c [#-#]${sRESET} (copy selection)"
  echo "$fBODY  ${sHL}tS -r [#-#]${sRESET} (rename selection)"
  echo "$fBODY  ${sHL}tS -t [#-#]${sRESET} (toss selection)"
  echo "$fBODY  ${sHL}tS -p [#-#]${sRESET} (pocket selection)"
  echo "$fBODY  ${sHL}tS -d [#-#]${sRESET} (delete selection)"
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tMake${sRESET}] Create new file/directory."
  echo "$fUSE  ${sHL}tMa -[option] [name]${sRESET}"
  echo "$fOPT  ${sHL}tMa -f [name]${sRESET} (create new file)"
  echo "$fBODY  ${sHL}tMa -d [name]${sRESET} (create new directory)"
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tMove${sRESET}] Move target file/directory."
  echo "$fUSE  ${sHL}tM [target] [destination]${sRESET} (move from target to destination)"
  echo "$fOPT  ${sHL}tM -f [target] [destination]${sRESET} (force move with no confirmation)"
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tCopy${sRESET}] Copy target file/directory."
  echo "$fUSE  ${sHL}tC [target] [destination]${sRESET} (copy from target to destination)"
  echo "$fOPT  ${sHL}tC -f [target] [destination]${sRESET} (force copy with no confirmation)"
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tDelete${sRESET}] Delete target file/directory."
  echo "$fUSE  ${sHL}tD [target]${sRESET} (delete target file/directory)"
  echo "$fOPT  ${sHL}tD -f [target]${sRESET} (force deletion with no confirmation)"
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tSave${sRESET}] Save copy of target using ${sBBLUE}rsync${sRESET}."
  echo "$fUSE  ${sHL}tSv [target]${sRESET} (save copy as [target].save)"
  echo "$fBODY  ${sHL}tSv [target] [name]${sRESET} (save copy as [name].save)"
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tLoad${sRESET}] Load saved copy of target using ${sBBLUE}rsync${sRESET}."
  echo "$fUSE  ${sHL}tL [target]${sRESET} (load [target].save as [target])"
  echo "$fBODY  ${sHL}tL [target] [name]${sRESET} (load [target].save as [name])"
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tLock${sRESET}] Lock target using ${sBBLUE}openssl${sRESET}."
  echo "$fUSE  ${sHL}tLc [target]${sRESET} (lock target and retain original)"
  echo "$fOPT  ${sHL}tLc -d [target]${sRESET} (lock target and delete original)"
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tUnlock${sRESET}] Unlock targets locked with ${sBBLUE}tLock${sRESET}."
  echo "$fUSE  ${sHL}tUn [target]${sRESET} (unlock target and retain original)"
  echo "$fOPT  ${sHL}tUn -d [target]${sRESET} (unlock target and delete original)"
  echo "$fEMPTY"
  echo "$fEXMPL ${sHL}tUn Receipts${sRESET} to unlock a file called \"Receipts.lock\"."
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tWrite${sRESET}] Write to target file."
  echo "$fUSE  ${sHL}tW \"[string]\" [target]${sRESET} (append string to target)"
  echo "$fOPT  ${sHL}tW -r \"[string]\" [target]${sRESET} (replace target with string)"
  echo "$fEMPTY"
  echo "$fTIP ${sBBLUE}tWrite${sRESET} can be used to create new files"
  echo "$fBODY  using the ${sBBLUE}replace${sRESET} option."
  echo "$fBODY  With this option, the target will be"
  echo "$fBODY  created if it does not already exist."
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tEdit${sRESET}] Open file for editing."
  echo "$fUSE  ${sHL}tE [target]${sRESET}"
  echo "$fEMPTY"
  echo "$fTIP ${sBBLUE}tEdit${sRESET} uses your preferred ${sBBLUE}EDITOR${sRESET}"
  echo "$fBODY  (generally defined in your \"~/.bashrc\" file)."
  echo "$fBODY  Otherwise, it will default to ${sBBLUE}vim${sRESET}."
  echo "$fEMPTY"
  echo "$fMARK [${sBCYAN}tReplace${sRESET}] Replace specified strings in a target file."
  echo "$fUSE  ${sHL}tRp [target] \"[search phrase]\" \"[replacement phrase]\"${sRESET}"
  echo "$fEMPTY"
  echo "$fTIP ${sBBLUE}tReplace${sRESET} will ignore lines containing the safeword,"
  echo "$fBODY  ${sBBLUE}wHiskey${sRESET} (caps sensitive)."
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


# tUnlock callable function.
tUn() {
  if [ -z "$1" ]; then
    tA_too_few_arguments
  elif [ "$1" = "--delete" ] || [ "$1" = "-d" ]; then
    if [ -z "$2" ]; then
      tA_too_few_arguments
    elif [ -f "$2" ] && [[ "$2" = *.lock ]]; then
      unlockFile="${2%.lock}"
      if [[ "$unlockFile" = *.tar ]]; then
        unlockMode="Directory"
      fi
      openssl enc -d -aes-256-cbc -salt -in "$2" -out "$unlockFile" -pbkdf2
      if [ "$unlockMode" = "Directory" ]; then
        tar -xf "$unlockFile"
        rm "$unlockFile"
      fi
      rm "$2"
    else
      tA_invalid_argument
    fi
  elif [ -f "$1" ] && [[ "$1" = *.lock ]]; then
    unlockFile="${1%.lock}"
    if [[ "$unlockFile" = *.tar ]]; then
      unlockMode="Directory"
    fi
    openssl enc -d -aes-256-cbc -salt -in "$1" -out "$unlockFile" -pbkdf2
    if [ "$unlockMode" = "Directory" ]; then
      tar -xf "$unlockFile"
      rm "$unlockFile"
    fi
  else
    tA_invalid_argument
  fi
  unlockMode="File"
}


# tLock callable function.
tLc() {
  if [ -z "$1" ]; then
    tA_too_few_arguments
  elif [ "$1" = "--delete" ] || [ "$1" = "-d" ]; then
    if [ -z "$2" ]; then
      tA_too_few_arguments
    elif [ -f "$2" ]; then
      openssl enc -aes-256-cbc -salt -in "$2" -out "$2.lock" -pbkdf2
      rm "$2"
    elif [ -d "$2" ]; then
      tar -czvf "$2.tar" "$2"
      openssl enc -aes-256-cbc -salt -in "$2.tar" -out "$2.tar.lock" -pbkdf2
      rm -rf "$2"
      rm "$2.tar"
    else
      tA_invalid_argument
    fi
  elif [ -f "$1" ]; then
    openssl enc -aes-256-cbc -salt -in "$1" -out "$1.lock" -pbkdf2
  elif [ -d "$1" ]; then
    tar -czvf "$1.tar" "$1"
    openssl enc -aes-256-cbc -salt -in "$1.tar" -out "$1.tar.lock" -pbkdf2
    rm "$1.tar"
  else
    tA_invalid_argument
  fi
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


# tSelect callable function.
tS() {
  mFlag=false
  cFlag=false
  rFlag=false
  dFlag=false
  tFlag=false
  pFlag=false
  modeChanged=false
  if [ -f "$cS" ]; then
    rm "$cS"
  fi
  if [ ! -f "$cVLS" ]; then
    echo "$fBLANK"
    echo "$fERROR ${sBBLUE}tView${sRESET} cache is empty."
  elif [ -z "$2" ]; then
    tA_too_few_arguments
  else
    while (( $# > 0 )); do
      while IFS= read -r line; do
        if [ "$1" = "-m" ] && [ "$modeChanged" = false ]; then
          mFlag=true
          modeChanged=true
        elif [ "$1" = "-c" ] && [ "$modeChanged" = false ]; then
          cFlag=true
          modeChanged=true
        elif [ "$1" = "-r" ] && [ "$modeChanged" = false ]; then
          rFlag=true
          modeChanged=true
        elif [ "$1" = "-t" ] && [ "$modeChanged" = false ]; then
          tFlag=true
          modeChanged=true
        elif [ "$1" = "-p" ] && [ "$modeChanged" = false ]; then
          pFlag=true
          modeChanged=true
        elif [ "$1" = "-d" ] && [ "$modeChanged" = false ]; then
          dFlag=true
          modeChanged=true
        fi
        number=$(cut -d ':' -f 1 <<< "$line")
        path=$(cut -d ':' -f 2- <<< "$line")
        fullPath=$(realpath -q "$path")
        if [[ "$number" = "$1" || ( "$number" -ge "$(echo "$1" | cut -d '-' -f 1)" && "$number" -le "$(echo "$1" | cut -d '-' -f 2)" ) ]]; then
          echo "$fullPath" >> "$cS"
        fi
      done < "$cVLS"
      shift
    done
    if [ -f "$cS" ]; then
      if [ "$mFlag" = true ]; then
        tS_move
      elif [ "$cFlag" = true ]; then
        tS_copy
      elif [ "$rFlag" = true ]; then
        tS_rename
      elif [ "$dFlag" = true ]; then
        tS_delete
      elif [ "$tFlag" = true ]; then
        tS_toss
      elif [ "$pFlag" = true ]; then
        tS_pocket
      fi
    else
      tA_invalid_argument
    fi
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

