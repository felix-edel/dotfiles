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

    # Update ruby/gem
    sudo gem update --system
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


# TODO Install ports

# If ports cannot be installed and/or some compile error occurs, try:
# $ xcode-select --install
# $ sudo xcode-select -switch /Library/Developer/CommandLineTools
