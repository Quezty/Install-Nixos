#!/usr/bin/env bash 


main() {
    clear

    echo -e "Starting installation of Quezty's Nixos \n \n"

    echo -e 'In order for the script to work, do the following steps before installing \n \n - Install git \n - add the line "nix.settings.experimental-features = [ "nix-command" "flakes" ];" to your existing config'

    echo -e "\n \n \n"


    line=$(nix config show 2>/dev/null | grep "experimental-features" ) || {
        echo 'Command "nix config show" failed, make sure you are running this on a system where nix is installed and the nix command is available!'
        exit 0
    }

    # Quietly runs grep on the output of variable "line" to see if flakes and nix-command is enabled 
    if echo "$line"	| grep -qw flakes && echo "$line" | grep -qw nix-command; then
	    echo "Experimental features enabled"
    else 
	    echo "Experimental features needed for the script to work was not enabled add the following lines to your configuration for the script to work"
        echo -e '- nix.settings.experimental-features = [ "nix-command" "flakes" ]; \n \n'
        exit 0
    fi

    is_git_installed=$(git -v)

    if [[ -z "$is_git_installed" ]]; then
        echo "git is not installed, install git and try again"
        exit 0
    else 
        echo "git is installed, downloading used repositories"
        # downloadRepositories
    fi

    if [ -d "$HOME/nixos" ]; then
        echo "Directory exists"
    else
        echo "Creating directory to move configuration into"
        mkdir ~/nixos
        echo "nixos folder created in home directory of $USER"
    fi
}

# Function to "cleanly" list all repositories that needs to be installed for the system to be complete, will probably remove this once I have landed on a better repository structure
downloadRepositories() {
    git clone https://github.com/Quezty/NixosConfiguration.git tmp-files/NixosConfiguration
    git clone https://github.com/Quezty/Justfile.git tmp-files/Justfile
}
main "$@"
