# adam12 dotfiles

These are my dotfiles. They are usually kept fairy up to date, depending on my
mood. The GNU package [stow](https://www.gnu.org/software/stow/) is used to
properly symlink folders into your home directory.

## Available Packages

- bin
- cvs
- direnv
- git
- ledger
- nvim
- rails
- ruby
- stow
- tmux
- vim
- zsh

## Install

	git clone https://github.com/adam12/dotfiles.git ~/.dotfiles
	cd ~/.dotfiles
	stow <package>

## Uninstall

	cd ~/.dotfiles
	stow -D <package>
