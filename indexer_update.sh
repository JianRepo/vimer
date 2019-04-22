#! /bin/bash

indexer_files=$HOME/.indexer_files

path=$(readlink -f `pwd`)

# write dirname to $HOME/.indexer_files
grep -w $path $indexer_files > /dev/null
if [ $? -ne 0 ]; then
  echo -e "[%dir_name($path)%]" >> $indexer_files
  echo $path >> $indexer_files
  echo >> $indexer_files
  echo -e "\e[0;32madd to ~/.indexer_files proj_path=$path\e[0m"
fi
# update tag
ctags -f "$HOME/.indexer_files_tags/${path##*/}"  -R -a --sort=yes  --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+iaSl --extra=+q "${path##*/}"
echo -e "\e[0;32mupdate tag file ${path##*/}\e[0m"
