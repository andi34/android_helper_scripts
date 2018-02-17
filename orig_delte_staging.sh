#!/bin/bash

SOURCE_DIR=/path/to/source

function delete_staging {
local IFS=$'\n'
REPOS=$(repo list)
for repo in $REPOS; do
    path=$(echo $repo | cut -d':' -f1 | tr -d ' ')
    name=$(echo $repo | cut -d':' -f2 | tr -d ' ')
    if [[ $name == *"SlimRoms"* ]]; then
       #echo $name
       cd $path
       if [[ $(git remote) != *"gerrit"* ]]; then
           git remote add gerrit https://REPLACEME@review.slimroms.org:29418/$name
       fi
       for branch in $(git branch -r | grep github | grep staging); do
           branch=$(echo $branch | cut -d'/' -f 2-7)
           echo "git push gerrit --delete refs/heads/$branch"
        done
       cd $SOURCE_DIR
   fi

done
}

delete_staging
