#! /usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename "${__file}")"
__dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

arg1="${1:-}"

error() { echo "-- [ERROR] ${*}" 1>&2 && false; }
info() { echo "-- [INFO] ${*}" 1>&2; }
warning() { echo "-- [WARNING] ${*}" 1>&2; }

# TODO
# 1. Install ports (and enable necessary 'default' settings)
#    -> coreutils, tree, python37, vim, macvim, grep, ..
# 2. Install tpm (tmux plugin manager)
# 3. Install powerfont (clone repo, run ./install.sh, delete repo)
# 4. Install python3 and create tools virtualenv
# 5. Symlink executables from the tools virtualenv to ~/bin
# 6. Symlink necessary configuration files (.vimrc, .zshrc, .tigrc, .tmux.conf)
# 7. Create the swapfiles dir for vim ($HOME/.vim/swapfiles)

# Requirements:
# 1. Install/update xcode and the xcode command line tools
#    $ xcode-select --install
# 2. Accept the licence agreement
#    $ xcodebuild -license

# Thinks you need to do manually (afterwards):
# 1. Create a ~/.gitconfig_local file with private settings like username, email, gpg key
# 2. Crate a gpg key for GitHub

print_help() {
    echo "Usage:

    ./${__base} <command>

    Commands:

        help            This help message
        clean           Clean package managers (port)
        macos           Apply macOS system defaults
        update [--osx]  Update package and package managers (port, npm)
                        Use the --osx flag to also update macOS.

    "
}

sub_clean() {
    sudo port clean --all installed # TODO -f option?
    sudo port uninstall inactive # TODO -f option?
}

sub_update() {
    # The macOS update takes very long, even if there is nothing to update.
    # Thus, we make it optional
    if [ -n "${1:-}" ]; then
        read -p "The macOS update could take a while. Continue (y/n)? " yn
        case "${yn:0:1}" in
            y|Y)
                softwareupdate -i -a
                ;;
            *)
                echo "Skipping macOS update"
                ;;
        esac
    fi

    # Update MacPorts
    sudo port selfupdate
    sudo port upgrade outdated

    # Update npm
    npm install npm -g
    npm update -g
}

sub_macos() {
    defaults_file="${__dotfiles_dir}/.osxdefaults"
    echo "Applying ${defaults_file}" && source "${defaults_file}"
}

case ${arg1} in
    "" | "-h" | "--help")
        print_help
        ;;
    *)
        shift
        sub_${arg1} $@
        if [ $? = 127 ]; then
            error "'${arg1}' is not a known command."
            print_help
        fi
        ;;
esac
shift
