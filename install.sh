#!/usr/bin/env bash

# default arguments
USERNAME=${1}
PASSWORD=${2}

INSTALL_NVM="wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | bash"
INSTALL_NODE=". /Users/$USER/.nvm/nvm.sh install stable"
USE_NODE=". /Users/$USER/.nvm/nvm.sh use stable"

INSTALL_MVN="brew install mvnvm"
ENCRYPT_PASSWORD="mvn --encrypt-master-password ${PASSWORD}"
ENCRYPTED_PASSWORD=""

UPDATE_BREW="brew update"
INSTALL_GIT="brew install git"

SETUP_ENV_VARIABLES="node scripts/setup_env_variables.js"
SETUP_SECURITY="node scripts/setup_security.js ${USERNAME} "
SETUP_SETTINGS="node scripts/setup_settings.js  ${USERNAME} "

INSTALL_CASK="brew install caskroom/cask/brew-cask"

INSTALL_WEBSTORM="brew cask install webstorm"

INSTALL_SUBLIME="brew cask install sublime-text"

INSTALL_INTELLIJ="brew cask install intellij-idea"

function install_nodejs() {
	echo "Installing Node"
	( $INSTALL_NVM ) 2>&1 > /dev/null
	( $INSTALL_NODE ) 2>&1 > /dev/null
	( $USE_NODE ) 2>&1 > /dev/null
	echo "... done"
}

function install_brew() {
    echo "Installing Brew"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 2>&1 > /dev/null
	echo "... done"
}

function install_cask() {
	echo "Installing CASK"
    ( $UPDATE_BREW ) 2>&1 > /dev/null
	( $INSTALL_CASK ) 2>&1 > /dev/null
	echo "... done"
}

function install_webstorm() {
	echo "Installing Webstorm"
    ( $INSTALL_WEBSTORM ) 2>&1 > /dev/null
	echo "... done"
}

function install_sublime() {
	echo "Installing Sublime"
	( $INSTALL_SUBLIME ) 2>&1 > /dev/null
	echo "... done"
}

function install_intellij() {
	echo "Installing IntelliJ"
	( $INSTALL_INTELLIJ ) 2>&1 > /dev/null
	echo "... done"
}

function install_mvn() {
    echo "Installing Maven and Java"
    ( $UPDATE_BREW ) 2>&1 > /dev/null
	( $INSTALL_MVN ) 2>&1 > /dev/null
	ENCRYPTED_PASSWORD="$($ENCRYPT_PASSWORD)"
	setup_settingsxml
	setup_securitysettingsxml
	echo "... done"
}

function install_git() {
    echo "Installing GIT"
    ( $UPDATE_BREW ) 2>&1 > /dev/null
	( $INSTALL_GIT ) 2>&1 > /dev/null
	echo "... done"
}

function setup_env_variables() {
    echo "Setting up environment variables"
	( $SETUP_ENV_VARIABLES ) 2>&1 > /dev/null
	echo "... done"
}

function setup_settingsxml() {
    echo "Setting settings.xml"
	( $SETUP_SETTINGS${ENCRYPTED_PASSWORD} ) 2>&1 > /dev/null
	echo "... done"
}

function setup_securitysettingsxml() {
    echo "Setting security-settings.xml"
	( $SETUP_SECURITY${ENCRYPTED_PASSWORD} ) 2>&1 > /dev/null
	echo "... done"
}


function main() {
	install_nodejs
	install_brew
	install_mvn
	install_git
	setup_env_variables
	install_cask
	install_webstorm
	install_sublime
	install_install_intellij
}

# run the servers
main

