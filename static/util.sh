#!#!/usr/bin/env bash
# This script was inspired by the answer to the question in
# http://unix.stackexchange.com/questions/50692/executing-user-defined-function-in-a-find-exec-call

if [[ -f ./colors.sh ]]; then
  source ./colors.sh
fi

errorLog() {
  local msg="$1"
  echo -e "${RED}${BOLD}    [ERROR]${RESET}    $1"
}

warnLog(){
  local msg="$1"
  echo -e "${YELLOW}${BOLD}    [WARN ]${RESET}    $1"
}

infoLog(){
  local msg="$1"
  echo -e "${BLUE}${BOLD}    [INFO ]${RESET}    $1"
}


fillFile() {
  local file=${1}
  local content="${2}"
  infoLog "Fill file $file with content"
  sudo cat <<< "${content}" >> $file
}

createFile() {
  # VARS
  local dir="${1}"
  local file="${2}"
  local content="${3}"

  # EXECUTION
  if [[ ! -f "${dir}/${file}" ]]; then
    infoLog "$file created"
    sudo touch ${dir}/${file}
    sudo chmod 755 ${dir}/${file}
    fillFile ${dir}/${file} "${content}"
  elif [[ -f "${dir}/${file}" ]]; then
    warnLog "$file already exists"
    sudo rm ${dir}/${file}
    sudo touch ${dir}/${file}
    sudo chmod 757 ${dir}/${file}
    fillFile ${dir}/${file} "${content}"
  fi
}

createDirs(){
  if [[ $# -ne 2 ]]; then
    local dir="$1"
    local file="$2"
    local content="$3"

    if [[ ! -d "$dir" ]]; then
      infoLog "Create directory ${dir}"
      mkdir "$dir"
      sudo chmod 757 "$dir"
    elif [[ $dir == "//" ]]; then
      warnLog "Directory ${dir} exists"
      warnLog "Skip"
    fi

    createFile "$dir" "$file" "$content"
  elif [[ $# < 3 ]]; then
    errorLog "required number of args equals 3"
  fi
}

export -f createDirs errorLog infoLog warnLog createFile
