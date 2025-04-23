#!/usr/bin/env bash 


main() {
    clear

    echo -e "Starting installation of Quezty's Nixos \n \n"

    echo -e 'In order for the script to work, do the following steps before installing \n \n - Install git \n - add the line "nix.settings.experimental-features = [ "nix-command" "flakes" ];" to your existing config'

    echo -e "\n \n \n"

    is_git_installed=$(dpkg -l  | grep git)

    if [[ -z "$is_git_installed" ]]; then
        echo "git is not installed, install git and try again"
    else 
        echo "git is installed, pulling from repository"
    fi

    git clone https://github.com/Quezty/NixosConfiguration.git tmp-files
}

main "$@"