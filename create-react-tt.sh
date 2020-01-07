#!/usr/bin/env bash
#Author emil.wozniak.591986@gmail.com

#VARIABLES
name=$1

dirname="$(dirname "$0")"
dirtarget="$(pwd)"

if [[ -d ${dirname}/static ]]; then
  source ${dirname}/static/colors.sh
  source ${dirname}/static/util.sh
  source ${dirname}/static/vars.sh
fi

# declare array of variables
if [[ -f ${dirname}/static/vars.sh ]]; then
  files=("${postcss}" "${tailwind_config}" "${app_tsx}" "${style_constant}" "${header}" "${grid}" "${footer}")
fi

infoLog "executing: ${dirname}"
infoLog "working:   ${dirtarget}"

if [[ $# == 1 ]]; then

  # YARN OPS
  infoLog 'CREATE REACT --typescript APP '
  sudo yarn create react-app --template typescript "$name"
  infoLog "change to ${dirtarget}/${name}"
  cd ./${name}

  infoLog 'ADD REACT DEPENDENCIES '
  sudo yarn add react-router-dom react-redux axios redux-promise-middleware @types/redux-promise-middleware redux-thunk @types/redux-thunk typescript @types/react @types/react-dom react-loadable @types/react-loadable @types/react-router-dom @types/react-redux

  infoLog 'ADD DEV DEPENDENCIES '
  sudo yarn add tailwindcss --dev
  sudo npx tailwind init tailwind.js --full
  cd ${dirtarget}/${name}

  # CHANGE ACCESS
  sudo chmod -R 757 ${dirtarget}/${name}/src ${dirtarget}/${name}/.git
  sudo chmod 757 ${dirtarget}/${name}/App.tsx
  sudo chmod 757 ${dirtarget}/${name}/package.json

  # TAILWIND
  infoLog 'TAILWIND CONFIGS '
  if [[ ! -f postcss.config.js ]]; then
    createFile "${dirtarget}/${name}" "postcss.config.js" "${postcss}"
    createFile "${dirtarget}/${name}" "tailwind.css" "${tailwind}"
    createFile "${dirtarget}/${name}" "tailwind.config.js" "${tailwind_config}"
    sed -i "${package_react_start}" "${dirtarget}/${name}"/package.json
    sed -i "${package_react_build}" "${dirtarget}/${name}"/package.json
    sed -i 's/  min-height: 100vh;/  min-height: 10vh;/g' "${dirtarget}/${name}"/src/App.css
  fi

  # CREATE files
  infoLog  'CREATE FILES '
  createFile "${dirtarget}/${name}" "App.tsx" "${app_tsx}"
  createFile "${dirtarget}/${name}" "postcss.config.js" "${postcss}"

  sudo mkdir ${dirtarget}/${name}/src/components
  sudo mkdir ${dirtarget}/${name}/src/components/shared
  sudo mkdir ${dirtarget}/${name}/src/components/shared/layout
  sudo chmod -R 757 ${dirtarget}/${name}

  createDirs "${dirtarget}/${name}/src/components/shared/layout/header" "header.tsx" "${header}"
  createDirs "${dirtarget}/${name}/src/components/shared/layout/styles" "style-constants.tsx" "${style_constant}"
  createDirs "${dirtarget}/${name}/src/components/shared/layout" "grid.components.tsx" "${grid}"
  createDirs "${dirtarget}/${name}/src/components/shared/layout/footer" "footer.tsx" "${footer}"
elif [[ $# < 1 ]]; then
  errorLog "required number of args equals 1"
  exit 1
fi

git add .
git commit -am "create with tailwind"

exit 0
