#!/bin/bash

SOURCE_DIR=~/android/aosp-7.1

function add_gerrit_remote {
local IFS=$'\n'
REPOS=$(repo list)
for repo in $REPOS; do
	path=$(echo $repo | cut -d':' -f1 | tr -d ' ')
	name=$(echo $repo | cut -d':' -f2 | tr -d ' ')
	if [[ $name == *"android_"* ]]; then
		cd $path
		if [[ $(git remote) == *"unlegacy"* ]]; then
			echo "$name"
			if [[ $(git remote) != *"gerrit"* ]]; then
           			git remote add gerrit ssh://andi34@gerrit.unlegacy-android.org:29418/$name
			else
				echo "gerrit remote exist"
				git remote -v
			fi
		fi

	cd $SOURCE_DIR
	fi

done
}

add_gerrit_remote
