# dotfiles

Basic dotfiles, managed using [Stow](https://www.gnu.org/software/stow/).

# Setup

* install `stow` from whatever package manager is used on this machine.
* `mkdir ~/.dotfiles` to hold dotfiles (or `git clone ... ~/.dotfiles`
* `stow -S ...` the relevant directories and dotfiles

# Post-install

After restoring dotfiles, development environment setup might need some or all of the following.

* `git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go`
* `git clone https://github.com/Glench/Vim-Jinja2-Syntax.git ~/.vim/pack/plugins/start/Vim-Jinja2-Syntax`
* `git clone https://github.com/vmware-archive/salt-vim.git  ~/.vim/pack/plugins/start/salt-vim`
