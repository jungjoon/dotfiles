#!/bin/bash

for name in `find . -maxdepth 1 -type f | grep -v install.sh | grep -v README`
do
  file="${HOME}/$name"
  if [[ -h "$file" || ! -e "$file" ]]; then
    echo "(re-)link symlink for $file"
    ln -sf "${PWD}/$name" "$file"
  else
    echo "$file is not a file or a symlink"
  fi
done

if [[ ! -d ~/bin ]]; then
  echo "dir ~/bin not found => ... creating"
  mkdir ~/bin
fi

for name in `find bin -type f`
do
  file="${HOME}/$name"
  if [[ -h "$file" || ! -e "$file" ]]; then
    echo "(re-)link symlink for $file"
    ln -sf "${PWD}/$name" "$file"
  else
    echo "$file is not a file or a symlink"
  fi
done

echo "Add belows lines into .bashrc"
echo ""
echo "if [ -f ~/.bashrc_local ]; then"
echo "   source ~/.bashrc_local"
echo "fi"
