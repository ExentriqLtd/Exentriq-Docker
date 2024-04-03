#!/bin/bash

parent_dir="$(dirname "$(pwd)")"

# required repos
repositories=(
  "git@github.com:ExentriqLtd/meteor-easy-search.git"
  "git@github.com:ExentriqLtd/meteor-streamer.git"
  "git@github.com:ExentriqLtd/meteor-autocomplete.git"
  "git@github.com:ExentriqLtd/Exentriq-MSP.git"
  "git@github.com:ExentriqLtd/Exentriq-EMA.git"
  "git@github.com:ExentriqLtd/Exentriq-ROMEO.git"
)

for repo_url in "${repositories[@]}"
do
    repo_name=$(basename "$repo_url" ".git")
    git clone "$repo_url" "$parent_dir/$repo_name"
done

mkdir "$parent_dir/exentriq-packages"
mv "$parent_dir/meteor-autocomplete" "$parent_dir/exentriq-packages"

# install node_modules for "Custom Board"
cd "$parent_dir/Exentriq-MSP/npm/exentriq-components"
npm rebuild node-sass
npm i
# prepare Custom Board for meteor projects (EMA/ROMEO)
npm run build_meteor

# prepare EMA
cd "$parent_dir/Exentriq-EMA"
meteor npm i
cp ./run_template.sh ./run.sh
cp ./settings-development.json ./settings-local.json

# prepare ROMEO
cd "$parent_dir/Exentriq-ROMEO"
meteor npm i
cp ./run_template.sh ./run.sh
cp ./settings-development.json ./settings-local.json
