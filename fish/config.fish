set -x DOTFILES $HOME/.dotfiles
set -x PATH /usr/local/bin $HOME/.cargo/bin $DOTFILES/bin ~/bin $PATH
set -x MANPATH /usr/local/man /usr/local/mysql/man /usr/local/git/man $MANPATH
set -x EDITOR /usr/local/bin/emacsclient

# https://medium.com/@joshuacrass/nvm-on-mac-for-fish-users-e00af124c540
function nvm
   bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
end
set -x NVM_DIR ~/.nvm
nvm use default --silent

# https://fishshell.com/docs/current/cmds/fish_git_prompt.html
# https://mariuszs.github.io/blog/2013/informative_git_prompt.html
function fish_prompt
    set -g __fish_git_prompt_show_informative_status 1
    set -g __fish_git_prompt_hide_untrackedfiles 1

    set -g __fish_git_prompt_color_branch magenta
    set -g __fish_git_prompt_showupstream "informative"
    set -g __fish_git_prompt_char_upstream_ahead "↑"
    set -g __fish_git_prompt_char_upstream_behind "↓"
    set -g __fish_git_prompt_char_upstream_prefix ""

    set -g __fish_git_prompt_char_stagedstate "●"
    set -g __fish_git_prompt_char_dirtystate "✚"
    set -g __fish_git_prompt_char_untrackedfiles "…"
    set -g __fish_git_prompt_char_conflictedstate "✖"
    set -g __fish_git_prompt_char_cleanstate "✔"

    set -g __fish_git_prompt_color_dirtystate blue
    set -g __fish_git_prompt_color_stagedstate yellow
    set -g __fish_git_prompt_color_invalidstate red
    set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
    set -g __fish_git_prompt_color_cleanstate green

    printf '%s %s $ ' (prompt_pwd) (fish_git_prompt)
end

end
