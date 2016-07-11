export ZSH=/Users/hjg/.oh-my-zsh
export PATH=${PATH}:/Users/hjg/Library/Android/sdk/platform-tools
export PATH=${PATH}:/Users/hjg/Library/Android/sdk/tools
export TERM=xterm-256color
source $(brew --prefix)/share/antigen.zsh

ZSH_THEME="dracula"

DEFAULT_USER="hjg"

plugins=(git autojump ruby bundler osx zsh-syntax-highlighting rails antigen)

source $ZSH/oh-my-zsh.sh

alias ctags="`brew --prefix`/bin/ctags"
alias ls="ls -FG"
alias hxps="hexo g && hexo g && hexo d"
alias hxdg="hexo s -g"
alias vi ='vim'
alias vim='nvim'
alias pc='proxychains4'
############################
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# melo powerline
set guifont=Menlo\ for\ Powerline

#alias for cnpm
alias cnpm="npm --registry=https://registry.npm.taobao.org \
  --cache=$HOME/.npm/.cache/cnpm \
  --disturl=https://npm.taobao.org/dist \
  --userconfig=$HOME/.cnpmrc"
## go 设置
#GOPATH
export GOPATH=$HOME/Documents/go_workspace
#GOPATH bin
export PATH=$PATH:$GOPATH/bin
#polipo
export http_proxy=http://127.0.0.1:7777
export https_proxy=$http_proxy

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
#neovim color
export NVIM_TUI_ENABLE_TRUE_COLOR=1


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_COMPLETION_TRIGGER='**'

