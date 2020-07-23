#! /bin/bash

currentBranch=$(git rev-parse --abbrev-ref HEAD);

mergedBranches () {
    git branch --merged | egrep -v "(^\*|master|develop|${currentBranch})"
}

echo "On branch ${currentBranch}";

echo "Merged branches:";

mergedBranches;

numMerged=$(mergedBranches | wc -l);

if [ $numMerged -eq 0 ]
then
    echo "No merged branches to delete!"
    exit 0;
fi

read -r -p "Remove ${numMerged} branches? [Y/n]" response
response=${response,,} # tolower
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
  mergedBranches | xargs git branch -d
else
  echo "Fine, whatever 🤷";
  exit 1;
fi
