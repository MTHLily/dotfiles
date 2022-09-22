if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Greeting

function fish_greeting
	neofetch
end

# Path Additions
fish_add_path $HOME/.local/bin
nvm use lts && clear
# Aliases
alias sail="[ -f sail ] && bash sail || bash vendor/bin/sail"
alias sa="sail artisan"
alias sap="sail php"
alias pa="php artisan"
alias ls="exa -al --icons"
alias vim="nvim"
alias sc="sudo systemctl"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias rscp='rsync --info=progress2 -auvz'

starship init fish | source
export PATH="$PATH:$HOME/.spicetify"
export GTK_IM_MODULE='fcitx'
export QT_IM_MODULE='fcitx'
export SDL_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'
