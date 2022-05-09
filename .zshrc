export ZSH=$HOME/.oh-my-zsh


plugins=(
  gh
  git
  git-extras
  git-auto-fetch
  extract
  web-search
  timer
  tmux
)

#ZSH_THEME="robbyrussell"
#ZSH_THEME="rkj-repos"
#ZSH_THEME="xiong-chiamiov-plus"
ZSH_THEME="agnoster"

ZSH_THEME_RANDOM_CANDIDATES=(
  "agnoster"
  "duellj"
  "amuse"
  "awesomepanda"
  "robbyrussell"
  "rkj-repos"
  "xiong-chiamiov-plus"
)

ENABLE_CORRECTION=true
CASE_SENSITIVE=false

#ZSH_TMUX_AUTOSTART=true

zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 14

source $ZSH/oh-my-zsh.sh

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"


# User Configuration

export EDITOR=nvim

export DEFAULT_USER="jona"

export TIMER_FORMAT='[%d]'

export MODE_INDICATOR="%F{yellow}+%f"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# User Aliases


alias config="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

alias vim="nvim"
alias v="nvim"

alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
