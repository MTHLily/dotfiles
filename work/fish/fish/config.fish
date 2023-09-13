if status is-interactive
  # Commands to run in interactive sessions can go here
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  nvm use lts/hydrogen -s

  if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
  end

  if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
  end

  alias vim="nvim"
  alias ls="exa -l"
  alias ll="exa -al"
  alias npmtool="npm i --prefix $HOME/.config/npm -g"

  source $HOME/.config/fish/abbreviations/git_abbr.fish

end
source $HOME/.config/fish/secrets.fish

set -Ux EDITOR nvim
set -Ux JIRA_API_TOKEN "NzQyMDE5NjM3ODQ1OgaE22eb2y527LvOo/+rCobd6TrP"
set -Ux JIRA_AUTH_TYPE bearer

fish_add_path $HOME/.config/fish/scripts
fish_add_path $HOME/.config/npm/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
