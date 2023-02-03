set -x DOTFILES $HOME/.dotfiles
set -x PATH /usr/local/bin /usr/local/opt/curl/bin $HOME/.cargo/bin $DOTFILES/bin ~/bin $PATH
set -x EDITOR (which emacsclient)

# Support Homebrew on Apple Silicon. This is a no-op if the directory doesn't
# exist, so it's safe to use on Intel-based machines.
fish_add_path /opt/homebrew/bin

# To collect command completions for all commands run:
#
#   `fish_update_completions`
#
# Also see: https://gist.github.com/gagarine/cf3f65f9be6aa0e105b184376f765262

# Store private environment variables (which aren't committed to the dotfiles
# repository) in ~/.localrc.fish.
if test -f ~/.localrc.fish
    source ~/.localrc.fish
end

# https://medium.com/@joshuacrass/nvm-on-mac-for-fish-users-e00af124c540
# https://github.com/jorgebucaran/fisher
# https://github.com/edc/bass
# `brew install fisher; fisher install edc/bass; brew install nvm`
function nvm
   bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
end
set -x NVM_DIR ~/.nvm

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

# Shell-side configuration for vterm.
# https://github.com/akermu/emacs-libvterm#shell-side-configuration
# https://github.com/akermu/emacs-libvterm#shell-side-configuration-files
if [ "$INSIDE_EMACS" = 'vterm' ]
   if test -n "$EMACS_VTERM_PATH"
       if test -f "$EMACS_VTERM_PATH/etc/emacs-vterm.fish"
          source "$EMACS_VTERM_PATH/etc/emacs-vterm.fish"
       end
   end
   # Force direnv to load the .envrc file (if one exists). This automatically
   # happens when changing directories from within vterm, but not when opening
   # a new vterm instance. (Unclear why this is the case.)
   if test -f ".envrc"
       direnv reload
   end
end

# Hook direnv into the shell: https://direnv.net/docs/hook.html
# To install direnv: `brew install direnv`
direnv hook fish | source
