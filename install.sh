#!/bin/bash

ln -sf ${PWD}/.irbrc ~/
ln -sf ${PWD}/.emacs ~/
ln -sf ${PWD}/.tmux.conf ~/
ln -sf ${PWD}/.bash_common ~/
ln -sf ${PWD}/.vimrc ~/
ln -sf ${PWD}/.ackrc ~/
ln -sf ${PWD}/.ctags ~/

mkdir -p ~/bin
ln -sf ${PWD}/bin/cnt_ext ~/bin/
ln -sf ${PWD}/bin/s ~/bin/
ln -sf ${PWD}/bin/grp ~/bin/
ln -sf ${PWD}/bin/flist ~/bin/
ln -sf ${PWD}/bin/s_dec ~/bin/
ln -sf ${PWD}/bin/gacp ~/bin/
ln -sf ${PWD}/bin/evr ~/bin/
ln -sf ${PWD}/bin/s_enc ~/bin/
ln -sf ${PWD}/bin/objdump_raw ~/bin/
ln -sf ${PWD}/bin/clcn ~/bin/
ln -sf ${PWD}/bin/__git_ps1.rb ~/bin/
ln -sf ${PWD}/bin/tagpush ~/bin/

mkdir -p ~/bin/color_test
ln -sf ${PWD}/bin/color_test/true_color_test.py ~/bin/color_test/
ln -sf ${PWD}/bin/color_test/color-spaces.pl ~/bin/color_test/
ln -sf ${PWD}/bin/color_test/24-bit-color.sh ~/bin/color_test/

mkdir -p ~/.config/nvim
ln -sf ${PWD}/.config/nvim/init.vim ~/.config/nvim/

echo "Add belows lines into .bashrc"
echo ""
echo "if [ -f ~/.bashrc_local ]; then"
echo "   source ~/.bashrc_local"
echo "fi"
