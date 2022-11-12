###
# https://dev.to/alekseiberezkin/setting-up-react-typescript-app-without-create-react-app-oph
###

((!$#)) && echo No arguments supplied!

mkdir "$1"
cd "$1"
npm init -y

cd "$1"
yarn add -D typescript

TEMP_TSCONFIG="{\n  \"compilerOptions\": {\n    \"esModuleInterop\": true,\n    \"jsx\": \"react\",\n    \"module\": \"esnext\",\n    \"moduleResolution\": \"node\",\n    \"lib\": [\n      \"dom\",\n      \"esnext\"\n    ],\n    \"strict\": true,\n    \"sourceMap\": true,\n    \"target\": \"esnext\",\n  },\n  \"exclude\": [\n    \"node_modules\"\n  ]\n}";
echo -e "$TEMP_TSCONFIG" > tsconfig.json

yarn add -D webpack webpack-cli webpack-dev-server css-loader html-webpack-plugin mini-css-extract-plugin ts-loader

TEMP_WEBPACK_CONFIG="const prod = process.env.NODE_ENV === 'production';\n\nconst HtmlWebpackPlugin = require('html-webpack-plugin');\nconst MiniCssExtractPlugin = require('mini-css-extract-plugin');\n\nmodule.exports = {\n  mode: prod ? 'production' : 'development',\n  entry: './src/index.tsx',\n  output: {\n    path: __dirname + '/dist/',\n  },\n  module: {\n    rules: [\n      {\n        test: /\.(ts|tsx)$/,\n        exclude: /node_modules/,\n        resolve: {\n          extensions: ['.ts', '.tsx', '.js', '.json'],\n        },\n        use: 'ts-loader',\n      },\n      {\n        test: /\.css$/,\n        use: [MiniCssExtractPlugin.loader, 'css-loader'],\n      },\n    ]\n  },\n  devtool: prod ? undefined : 'source-map',\n  plugins: [\n    new HtmlWebpackPlugin({\n      template: 'index.html',\n    }),\n    new MiniCssExtractPlugin(),\n  ],\n};";
echo -e "$TEMP_WEBPACK_CONFIG" > webpack.config.js

TEMP_INDEX_HTML="<!DOCTYPE html>\n<html>\n<head lang=\"en\">\n  <title>Hello React</title>\n</html>\n<body>\n  <div id=\"app-root\">App is loading...</div>\n<script src=\"https://unpkg.com/react@18/umd/react.development.js\" crossorigin></script>\n<script src=\"https://unpkg.com/react-dom@18/umd/react-dom.development.js\" crossorigin></script>\n</body>";
echo -e "$TEMP_INDEX_HTML" > index.html

yarn add react react-dom
yarn add -D @types/react @types/react-dom

echo "/*replace script with the below commands*/"
TEMP_SCRIPT="\"start\": \"webpack serve --port 3000\",\n\"build\": \"NODE_ENV=production webpack\"";
echo -e "$TEMP_SCRIPT" >> package.json

mkdir src 
cd src
TEMP_SRC_INDEX="import React from 'react'\nimport { createRoot } from 'react-dom/client'\n\nconst container = document.getElementById('app-root')!\nconst root = createRoot(container)\nroot.render(<h1>Hello React!</h1>)";
echo -e "$TEMP_SRC_INDEX" > index.tsx

