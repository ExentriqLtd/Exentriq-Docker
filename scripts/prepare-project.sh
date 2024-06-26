#!/bin/bash

parent_dir="$(dirname "$(pwd)")"

mkdir -p "$parent_dir/images-nas/ema-v2"
mkdir -p "$parent_dir/images-nas/talk-v2"

mkdir "$parent_dir/exentriq-packages"
mv "$parent_dir/meteor-autocomplete" "$parent_dir/exentriq-packages"

# install node_modules for "Custom Board"
cd "$parent_dir/Exentriq-MSP/npm/exentriq-components"
git submodule update --init --recursive
npm rebuild node-sass
npm i
npm run build

# prepare EMA
cd "$parent_dir/Exentriq-EMA"
meteor npm i
cp ./run_template.sh ./run.sh
cp ./settings-development.json ./settings-local.json
sed -i '' "s|\"rootFolder\": \"\"|\"rootFolder\": \"$parent_dir\"|g" ./settings-local.json

# prepare ROMEO
cd "$parent_dir/Exentriq-ROMEO"
meteor npm i
cp ./run_template.sh ./run.sh
cp ./settings-development.json ./settings-local.json
sed -i '' "s|\"rootFolder\": \"\"|\"rootFolder\": \"$parent_dir\"|g" ./settings-local.json

echo "\033[35m=============================================\033[0m"
echo "\033[32m"; echo "The project is successfully prepared"; echo "\033[0m"

echo "You also need to install and have running:"
echo "- MongoDB (version 4.4)"
echo "- Redis"

echo ""
echo "\033[35m=============================================\033[0m"
echo ""
