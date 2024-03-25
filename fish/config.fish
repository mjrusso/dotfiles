set -x DOTFILES $HOME/.dotfiles

fish_add_path ~/bin
fish_add_path $DOTFILES/bin
fish_add_path /usr/local/bin

# Support Homebrew on Apple Silicon. This is a no-op if the directory doesn't
# exist, so it's safe to use on Intel-based machines.
fish_add_path /opt/homebrew/bin

# To collect command completions for all commands run:
#
#   `fish_update_completions`
#
# Also see: https://gist.github.com/gagarine/cf3f65f9be6aa0e105b184376f765262

# Configure asdf and asdf-direnv.
# https://asdf-vm.com/
# https://github.com/asdf-community/asdf-direnv

set -x ASDF_DIR (brew --prefix asdf)/libexec
set -x ASDF_DIRENV_BIN (which direnv)

fish_add_path "$ASDF_DIR/bin"

# Hook direnv into the shell: https://direnv.net/docs/hook.html
direnv hook fish | source

# Store private environment variables (which aren't committed to the dotfiles
# repository) in ~/.localrc.fish.
if test -f ~/.localrc.fish
    source ~/.localrc.fish
end

set -x EDITOR (which emacsclient)

# https://fishshell.com/docs/current/cmds/fish_git_prompt.html
# https://mariuszs.github.io/blog/2013/informative_git_prompt.html
function fish_prompt
    # Disable fancy formatting when using Tramp:
    # https://www.gnu.org/software/tramp/#index-FAQ
    if test $TERM = "dumb"
        echo "\$ "
        return
    end

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

    # The exit status of the most recently-run command.
    # See: https://superuser.com/a/893187
    set -l _display_status $status

    set_color blue
    echo -n @(prompt_hostname) ""

    set_color normal
    echo -n (prompt_pwd)
    echo -n (fish_git_prompt)

    if test $_display_status -eq 0
        set_color green
        echo -n ' $'
    else
        set_color red
        echo -n " "
        echo -n [$_display_status]
        echo -n " >"
    end

    set_color normal
    echo -n " "
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

   # https://github.com/akermu/emacs-libvterm#vterm-clear-scrollback
   function clear
       vterm_printf "51;Evterm-clear-scrollback";
       tput clear;
   end

   # Force direnv to load the .envrc file (if one exists). This automatically
   # happens when changing directories from within vterm, but not when opening
   # a new vterm instance. (Unclear why this is the case.)
   if test -f ".envrc"
       direnv reload
   end
end
