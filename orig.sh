#!/bin/bash

SOURCE_DIR=/path/to/source

function merge_aosp {
local IFS=$'\n'
REPOS=$(repo list)
SUCCESSFUL=()
FAILED=()
for repo in $REPOS; do
    path=$(echo $repo | cut -d':' -f1 | tr -d ' ')
    name=$(echo $repo | cut -d':' -f2 | tr -d ' ')
    if [[ $name == *"SlimRoms"* ]]; then
       cd $path
       git remote remove aosp
       git remote add aosp https://android.googlesource.com/platform/$path
       git fetch aosp
       git merge --no-edit android-8.1.0_r1
       if [ $? -eq 0 ]; then
           SUCCESSFUL+=" $name \n"
           git push ssh://REPLACEME@review.slimroms.org:29418/$name HEAD:refs/heads/or8.1
        else
         FAILED+=" $name \n"
       fi
       cd $SOURCE_DIR
   fi

done

echo -e "\n\n"
echo -e SUCCESSFUL:
echo -e $SUCCESSFUL
echo -e "\n\n"
echo -e FAILED:
echo -e $FAILED
}

merge_aosp
