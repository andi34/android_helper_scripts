#!/bin/bash

SOURCE_DIR=~/android2/android-security/aosp-7.1

function update_all_repos {
local IFS=$'\n'
REPOS=$(repo list)
for repo in $REPOS; do
	path=$(echo $repo | cut -d':' -f1 | tr -d ' ')
	name=$(echo $repo | cut -d':' -f2 | tr -d ' ')

	if [[ $name == *"android_"* ]]; then
		cd $SOURCE_DIR/$path
		git branch -D aosp-7.1

		if git config remote.android-security.url > /dev/null; then
			echo "$name"
			echo "$path"
			git push android-security HEAD:aosp-7.1
		fi
		cd $SOURCE_DIR
	fi
done
}

update_all_repos
