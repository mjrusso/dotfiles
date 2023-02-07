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

- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. (These files get symlinked when you run `rake install`.)

  - symlinks can be generated in cases where these standard **topic/\*.symlink**
  symlink rules do not apply; see the `:install` task of the `Rakefile` for details.

- Create a file called `~/.localrc.fish` to store any environment variables
  that you do not want committed to this git repository (secrets, etc.). Note
  that this file should be in your home directory, _not_ this repository.

system
------

OS X, with the [Homebrew package manager](http://mxcl.github.com/homebrew/).

dependencies
------------

Assumes that [fish](https://fishshell.com/) is the default shell.

Requires [direnv](https://direnv.net/), [asdf](https://asdf-vm.com/), and
[asdf-direnv](https://github.com/asdf-community/asdf-direnv).

To install `direnv`: `brew install direnv`

(`direnv` is already [hooked into the
shell](https://direnv.net/docs/hook.html); see
[config.fish](./fish/config.fish).)

To install `asdf`: `brew install asdf`

To install `asdf-direnv`: `asdf plugin-add direnv`

After installing `asdf`, ignore the advice to source _asdf.fish_ (i.e., do *not* run:
`source (brew --prefix asdf)/libexec/asdf.fish`).

Next, set up `asdf` with `direnv`: `asdf direnv setup --shell fish --version system`

Review the files generated and/or modified by `asdf direnv setup`, and delete
`.config/fish/conf.d/asdf_direnv.fish`.

(All of the required sourcing is already configured in
[config.fish](./fish/config.fish).)

Install the relevant `asdf` plugins; for example, for Elixir:

```bash
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
```

To use `asdf`, add a `.tool-versions` file in the root of your project folder.
Continuing the Elixir example:

``` bash
$ cat .tool-versions
elixir 1.14.3
erlang 25.2.2
```

And, in the root of the project folder, add a `.envrc` file with the following
contents:

``` bash
$ cat .envrc
use asdf
```

The first time `cd`ing into the project directory, run `direnv allow`.

Also see: [.asdfrc](./asdf/asdfrc.symlink)

thanks
------

These dotfiles are heavily based on [Zach Holman's dotfiles](https://github.com/holman/dotfiles).

Also includes code from the following dotfiles:

- [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
- [Andrew Sardone](https://github.com/andrewsardone/dotfiles)
