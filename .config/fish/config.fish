if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Greeting

function fish_greeting
	neofetch
end

# Path Additions
fish_add_path $HOME/.local/bin

# Aliases
alias sail="[ -f sail ] && bash sail || bash vendor/bin/sail"
alias sa="sail artisan"
alias sap="sail php"
alias pa="php artisan"
alias ls="exa -al"
alias vim="nvim"
alias sc="sudo systemctl"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

starship init fish | source
