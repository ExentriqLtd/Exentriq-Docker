#!/bin/bash

parent_dir="$(dirname "$(pwd)")"

# required repos
repositories=(
  "git@github.com:ExentriqLtd/meteor-easy-search.git"
  "git@github.com:ExentriqLtd/meteor-streamer.git"
  "git@github.com:ExentriqLtd/meteor-autocomplete.git"
  "git@github.com:ExentriqLtd/jalik-ufs.git"
  "git@github.com:ExentriqLtd/Exentriq-MSP.git"
  "git@github.com:ExentriqLtd/Exentriq-EMA.git"
  "git@github.com:ExentriqLtd/Exentriq-ROMEO.git"
  "git@github.com:ExentriqLtd/Exentriq-MXGraph.git"
)

for repo_url in "${repositories[@]}"
do
    repo_name=$(basename "$repo_url" ".git")
    git clone "$repo_url" "$parent_dir/$repo_name"
done


echo "\033[35m=============================================\033[0m"
echo "\033[32m"; echo "All repos are successfully cloned"; echo "\033[0m"

echo "You also need to install and have running:"
echo "- MongoDB (version 4.4)"
echo "- Redis"

echo ""
echo "\033[35m=============================================\033[0m"
echo ""
