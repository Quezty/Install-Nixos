#!/usr/bin/env bash 


main() {
    clear

    echo -e "Starting installation of Quezty's Nixos \n \n"

    echo -e 'In order for the script to work, do the following steps before installing \n \n - Install git \n - add the line "nix.settings.experimental-features = [ "nix-command" "flakes" ];" to your existing config'

    echo -e "\n \n \n"


    line=$(nix config show | grep "experimental-features")

    if echo "$line"	| grep -qw flakes && echo "$line" | grep -qw nix-command; then
	    echo "Experimental features enabled"
    else 
	    echo "Experimental features needed for the script to work was not enabled add the following lines to your configuration for the script to work"
        echo -e '- nix.settings.experimental-features = [ "nix-command" "flakes" ]; \n \n'
    fi

    # is_git_installed=$(dpkg -l  | grep git)
    is_git_installed=$(git -v)

    if [[ -z "$is_git_installed" ]]; then
        echo "git is not installed, install git and try again"
    else 
        echo "git is installed, pulling from repository"
    fi

    git clone https://github.com/Quezty/NixosConfiguration.git tmp-files/NixosConfiguration


    if [ -d "$HOME/nixos" ]; then
        echo "Directory exists"
    else
        echo "Creating directory to move configuration into"
        mkdir ~/nixos
        echo "nixos folder created in home directory of $USER"
    fi
}

main "$@"
