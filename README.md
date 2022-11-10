# dotfiles

## Initial bootstrapping

Install iterm2: https://iterm2.com/
Install brew: https://brew.sh/

Install necessary tools with brew:
```bash
brew install coreutils direnv git hub node python@3.10 ruby tig tmux tree vim zsh
```

Clone this repository

```bash
git clone git@github.com:felixedel/dotfiles.git ~/.dotfiles
```

Symlink the necessary files into your `HOME` directory:
```bash
ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/git/.gitignore_global ~/.gitignore_global
ln -s ~/.dotfiles/npm/.npmrc ~/.npmrc
ln -s ~/.dotfiles/tig/.tigrc ~/.tigrc
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/vim/.vimrc ~/.vimrc
```

Install colorls via ruby/gem
```bash
gem install colorls
```
## ZSH

Install oh-my-zsh: https://ohmyz.sh/

Symlink the zsh config file into your `HOME` directory:
```bash
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
```

In case you created the symlink already before installing oh-my-zsh, the file
will be overwritten by the install procedure. Thus, you have to create it
again.

Clone necessary zsh plugin repositories

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Link the custom ZSH theme to the `oh-my-zsh` themes directory like so:

```bash
ln -s ~/.dotfiles/zsh/themes/felixedel.zsh-theme ~/.oh-my-zsh/themes/
```

## tmux

Install tmux plugin manager: https://github.com/tmux-plugins/tpm and install all
plugins via `prefix + I`.

## iTerm2 settings

### Profile settings
- **Color Theme:** Tango Dark
- **Font:** DejaVu Sans Mono Nerd Font Complete 13pt (https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf)
- **Terminal type:** xterm-256color

To allow jumping words via arrow keys, change the following key mappings in `profile -> keys`:
- `Option+<-`: `Send Escape Sequence` with value `b`
- `Option+->`: `Send Escape Sequence` with value `f`

### tmux integration
- **Open tmux windows as native windows**

### Vim setup

Clone vundle to manage Vim plugins
```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Create the vim swapfiles directory:
```bash
mkdir ~/.vim/swapfiles
```

On first start of vim, run `:PluginInstall` to install necessary plugins.

## VS Code
1. Install [FiraCode](https://github.com/tonsky/FiraCode) to enable font ligatures.
2. Link the `settings.json` file from this repository to the original VS Code settings location:
```bash
ln -s ~/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
```
3. Link the `keybindings.json` file from this repository to the original VS Code settings location:
```bash
ln -s ~/.dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
```

### Installed Plugins

This is a list of plugins, I've currently installed in vscode:

- Docker
- GitLens
- Jupyter
- Prettier
- Pylance
- Python
- Vim
- vscode-icons

## Links
**iTerm2 color schemes:** https://github.com/mbadolato/iTerm2-Color-Schemes
**Nerd font for agnoster theme with venv icon:** https://github.com/ryanoasis/nerd-fonts
**zsh themes:** https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
**How to write a ZSH theme:** https://blog.carbonfive.com/writing-zsh-themes-a-quickref/

### Misc
https://opensource.com/article/18/9/tips-productivity-zsh
