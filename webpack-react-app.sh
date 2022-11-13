###
# https://dev.to/alekseiberezkin/setting-up-react-typescript-app-without-create-react-app-oph
###

((!$#)) && echo No arguments supplied!

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TEMP_TSCONFIG=$(<"$SCRIPT_DIR"/templates/tsconfig.json)
TEMP_WEBPACK_CONFIG=$(<"$SCRIPT_DIR"/templates/webpack.config.js)
TEMP_INDEX_HTML=$(<"$SCRIPT_DIR"/templates/index.html)
TEMP_SCRIPT=$(<"$SCRIPT_DIR"/templates/package-script.txt)
TEMP_SRC_INDEX=$(<"$SCRIPT_DIR"/templates/index.tsx)
TEMP_GLOBALS_D_TS=$(<"$SCRIPT_DIR"/templates/globals.d.ts)
TEMP_GLOBALS_SCSS=$(<"$SCRIPT_DIR"/templates/globals.scss)

mkdir "$1"
cd "$1"
npm init -y

yarn add -D typescript

## Create tsconfig
echo -e "$TEMP_TSCONFIG" > tsconfig.json

## Add webpack related libraries
yarn add -D webpack webpack-cli webpack-dev-server css-loader html-webpack-plugin mini-css-extract-plugin ts-loader

## Add svg lib
## https://react-svgr.com/docs/webpack/
yarn add -D @svgr/webpack

## Add scss handles asper webpack 
## https://webpack.js.org/loaders/sass-loader/
yarn add -D style-loader dart-sass sass-loader sass

## Usage of environment variabls
yarn add -D dotenv-webpack

## create webpackfile
echo -e "$TEMP_WEBPACK_CONFIG" > webpack.config.js

## create index.html (used in run start and build)
echo -e "$TEMP_INDEX_HTML" > index.html

## add react & necessary types
yarn add react react-dom
yarn add -D @types/react @types/react-dom

## TODO replace scripts in package.json
echo -e "$TEMP_SCRIPT" >> package.json

## Create app index.ts
mkdir src 
cd src
echo -e "$TEMP_SRC_INDEX" > index.tsx
echo -e "$TEMP_GLOBALS_D_TS" > globals.d.ts
echo -e "$TEMP_GLOBALS_SCSS" > globals.scss