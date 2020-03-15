mjrusso's dotfiles
==================

My personalized system configuration. ([Inspiration](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/))

Also see: [my Emacs configuration](https://github.com/mjrusso/.emacs.d).

installation
------------

    git clone git://github.com/mjrusso/dotfiles ~/.dotfiles
    cd ~/.dotfiles
    rake install

notes
-----

- **bin/**: Anything in `bin/` will be added to your `$PATH` and be made
  available everywhere.

- **topic/\*.sh**: Any files ending in `.sh` get loaded into your environment.

- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. (These files get symlinked when you run `rake install`.)

  - symlinks can be generated in cases where these standard **topic/\*.symlink**
  symlink rules do not apply; see the `:install` task of the `Rakefile` for details.

- **.localrc**: Create a file called `.localrc` to store any data that you do
  not want committed to the git repository (secrets, etc.).

system
------

OS X, with the [Homebrew package manager](http://mxcl.github.com/homebrew/).

thanks
------

These dotfiles are heavily based on [Zach Holman's dotfiles](https://github.com/holman/dotfiles).

Also includes code from the following dotfiles:

- [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
- [Andrew Sardone](https://github.com/andrewsardone/dotfiles)
