#!/usr/bin/bash

## installing important software
sudo apt install zsh -y
sudo apt install git -y
sudo apt install wget -y

sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

## saving old zshrc file in case of need
mv .zshrc zshrc_old

## oh my zsh stuff
echo 'export ZSH="$HOME/.oh-my-zsh"' > .zshrc

## setting theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> .zshrc

## setting plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

printf "plugins=(\n    git\n    zsh-autosuggestions\n    zsh-syntax-highlighting\n    zsh-history-substring-search\n)\n\n" >> .zshrc
echo 'fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src' >> .zshrc
printf '\n' >> .zshrc

## oh my zsh stuff
echo 'source $ZSH/oh-my-zsh.sh' >> .zshrc
