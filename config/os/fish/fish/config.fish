# Source configuration to cleanup home directory
source "$HOME/.config/fish/ninja.fish"

if status is-interactive
  # Commands to run in interactive sessions can go here
  # Greeting
  function fish_greeting
  	cutefetch -b (random 0 13)
  end

  abbr -a yay paru

  # Aliases
  # General Aliases
  alias frl="source $HOME/.config/fish/config.fish"
  alias ls="exa -l --icons --group-directories-first"
  alias ll="exa -al --icons --group-directories-first"
  alias vim="nvim"
  alias sc="sudo systemctl"
  alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
  alias rscp='rsync --info=progress2 -auvz'

  # PHP/Laravel Aliases
  alias sail="[ -f sail ] && bash sail || bash vendor/bin/sail"
  alias sa="sail artisan"
  alias sap="sail php"
  alias pa="php artisan"
  
  nvm use default --silent

  starship init fish | source
end

# Path Additions
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.spicetify
fish_add_path $HOME/.config/npm/bin
fish_add_path $GOPATH/bin
fish_add_path $HOME/.config/luarocks/bin
fish_add_path $CARGO_HOME/bin
fish_add_path /home/maespera/.spicetify

# Env Var Declarations
set -gx GTK_IM_MODULE 'fcitx'
set -gx QT_IM_MODULE 'fcitx'
set -gx SDL_IM_MODULE 'fcitx'
set -gx XMODIFIERS '@im=fcitx'
set -gx EDITOR 'nvim'

# pnpm
set -Ux nvm_default_version "lts/hydrogen"
set -Ux PNPM_HOME "/home/maespera/.local/share/pnpm"
fish_add_path "$PNPM_HOME"

direnv hook fish | source
