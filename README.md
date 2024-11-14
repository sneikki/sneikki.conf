# `sneikki.conf`

## bash

* Customized prompt
* Some aliased commands
* Utility functions to save time

***Installation***

`ln -s <path-to-repo>/.bashrc ~/.bashrc`

## alacritty

* Broad range of color themes, from
[alacritty/**alacritty-theme**](https://github.com/alacritty/alacritty-theme) and
[rajasegar/**alacritty-themes**](https://github.com/rajasegar/alacritty-themes)
* Minor enhancements to look and feel

***Installation***

```sh
ln -s <path-to-repo>/alacritty/ ~/.config
```

## nvim

Configured with a bunch of plugins and custom commands.

***Installation***

1. Create symbolic link to nvim configuration: `ln -s <path-to-repo>/nvim/ ~/.config`

1. Install [junegunn/**vim-plug**](https://github.com/junegunn/vim-plug)
2. Open Neovim and run `:PlugInstall`
3. Everything should be downloaded and installed correctly

## tmux

***Installation***

```sh
ln -s <path-to-repo>/tmux/ ~/.config
```
