#!/bin/bash

git status .

read -p "Press Enter key to continue ... "

# bakup_email=`git config --get user.email`
# bakup_name=`git config --get user.name`

git config user.email "Elijah365@live.com"
git config user.name "Elijah365"

# git config --global user.email $bakup_email
# git config --global user.name $bakup_name

git add -A
git commit -m "`date +"%Y-%m-%d %H:%M"`"
git push
