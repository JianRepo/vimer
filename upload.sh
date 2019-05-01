#!/bin/bash

git status .

read -p "Press Enter key to continue ... "

git add -A
git commit -m "`date +"%Y-%m-%d %H:%M"`"
git push
