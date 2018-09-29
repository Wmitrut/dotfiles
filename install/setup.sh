#!/bin/bash
#
# Main install script


DOTFILES_DIRECTORY="$PWD"
DOTFILES_PATH="${HOME}"

source ./install/utils.sh

replace() {
    # Force move/replace files.
    mv -f "${DOTFILES_DIRECTORY}/${1}" "${HOME}/${2}"
}

replacefiles() {
    # Move/replace setting files to /Home
    replace ".bash_profile"     ".bash_profile"
    replace ".gitconfig"        ".gitconfig"
    replace ".gitignore_global" ".gitignore_global"

    e_success "Dotfiles update complete!"
}

# Ask before potentially overwriting files
seek_confirmation "Warning: This step may overwrite your existing dotfiles."
if is_confirmed; then
    replacefiles
    source ${HOME}/.bash_profile
else
    e_warning "Skipped dotfiles settings."
fi

# Git configs
e_header "Configure your Git settings: "
nano ${HOME}/.gitconfig
e_success "Git settings updated!"

# Before relying on Homebrew, check that packages can be compiled
e_header "Installing XCode Command Line Tools..."
xcode-select --install
e_success "XCode Command Line Tools install complete!"

# Install Brew and Cask packages
seek_confirmation "Warning: This step install Brew, Cask, Brew Cask Upgrade, MAS and applications."
if is_confirmed; then
    e_header "Please, configure you Brew settings and packages before installation."
    nano ${DOTFILES_DIRECTORY}/install/brew.sh
    bash ./install/brew.sh
    e_success "Brew and applications are installed!"
else
    e_warning "Skipped Brew settings update."
fi

# Install Zsh and ask before potentially overwriting overwriting files
seek_confirmation "Warning: This step install Zsh, Hack Nerd Font and some plugins."
if is_confirmed; then
    e_header "Please, if necessary, configure before installation."
    nano ${DOTFILES_DIRECTORY}/install/zsh.sh
    bash ./install/zsh.sh
    replace ".zshrc"    ".zshrc"
    e_success "Zsh and plugins are installed!"
    e_warning "Please, after finishing the installation, remember to change the font of your terminal app to your favorite Nerd Font."
else
    e_warning "Skipped Zsh settings update."
fi

# Ask before potentially overwriting macOS defaults
seek_confirmation "Warning: This step may modify your macOS system defaults."
if is_confirmed; then
    e_header "Please, configure you settings before installation.\n Dont restart the Mac in this step"
    nano ${DOTFILES_DIRECTORY}/install/macos.sh
    bash ./install/macos.sh
    e_success "macOS settings updated! You may need to restart."
else
    e_warning "Skipped macOS settings update."
fi

# Ask before potentially overwriting dock defaults
seek_confirmation "Warning: This step may modify your dock system defaults."
if is_confirmed; then
    e_header "Please, configure you dock settings before installation."
    nano ${DOTFILES_DIRECTORY}/install/dock.sh
    bash ./install/dock.sh
    e_success "Dock settings updated!"
else
    e_warning "Skipped Dock settings update."
fi

# Ask before potentially overwriting VSCode
seek_confirmation "Warning: This step may modify your VSCode configs."
if is_confirmed; then
    open -a Visual\ Studio\ Code.app
    sleep 2
    kill -9 $(pgrep Electron)
    replace "/vscode/settings.json"     "/Library/Application Support/Code/User/settings.json"
    replace "/vscode/keybindings.json"  "/Library/Application Support/Code/User/keybindings.json"
    e_header "Please, configure you plugins before installation."
    nano ${DOTFILES_DIRECTORY}/install/vscode.sh
    bash ./install/vscode.sh
    e_success "VSCode settings updated!"
else
    e_warning "Skipped VSCode settings update."
fi

# Install npm packages
seek_confirmation "Warning: This step install npm packages"
if is_confirmed; then
    e_header "Please, configure your npm packages before installation."
    nano ${DOTFILES_DIRECTORY}/install/npm.sh
    bash ./install/npm.sh
    e_success "npm packages are installed!"
else
    e_warning "Skipped npm settings update."
fi

# Create a directory for projects and development
e_header "Creating Projects directory in Home"
mkdir ${HOME}/Projects

# Remove the installation zip and folder
e_header "Removing unnecessary files"
rm -rf ${HOME}/dotfiles.tar.gz
rm -rf ${HOME}/dotfiles.zip
rm -rf ${DOTFILES_DIRECTORY}

seek_confirmation "Warning: This step enable trimforce for SSD. Only required if you use third-party SSDs."
if is_confirmed; then
    e_header "Enabling trimforce..."
    sudo trimforce enable
    e_success "Trimforce is enabled!"
else
    e_warning "Skipped trimforce update."
fi

e_success "Reboot and enjoy!"
