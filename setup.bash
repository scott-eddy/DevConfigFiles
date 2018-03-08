######
# Attempts to setup the environment such that
# the following tools are setup for a developer:
#   1. Installs dependencies for tmux.conf
#   2. Install dependencies for 
#
######
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[0;33m'
readonly BOLD='\e[1m'
readonly RESET_BOLD='\e[21m'
readonly NC='\033[0m'

OS_TYPE=""   # variable to hold the os type, e.g. Linux vs Mac
OS_DISTRO="" # e.g. Arch vs Ubuntu
OS_VERSION="" # e.g. 16.04

GetDistroVersion() {
  if command -v uname >/dev/null; then
    OS_TYPE=$(uname)
    echo "OS Type is: ${OS_TYPE}"
  else
    echo -e "${RED} Can't detect distro type!${NC}"
    return 1
  fi

  # More recent Linux distros have this, e.g. Ubuntu 16.04 and Arch
  if [ ${OS_TYPE} == "Linux" ]; then
    if [ -f /etc/os-release ]; then
      . /etc/os-release
      OS_NAME=$NAME
      OS_VERSION=$VERSION_ID 
      echo "OS Name is: ${OS_NAME}"
      echo "OS Version is: ${OS_VERSION}"
    else
      echo -e "${RED}Older linux version detected. See instructions: http://dilbert.com/strip/1995-06-24${NC}"
      return 2
    fi
  elif ${OS_TYPE} == "Darwin"; then
    ${OS_NAME}="Mac"
  fi
 
 return 0 
}


InstallTmuxPluginManager() {
  # Setup tmux plugin manager
  if [ -d "${HOME}/.tmux/plugins/tpm" ]; then
    echo -e "${YELLOW}${BOLD}WARNING:${RESET_BOLD} tmux plugin manager already installed, skipping${NC}"
  else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
}

InstallDconfCli() {
  if [ ${OS_NAME} == "Ubuntu" ]; then
    echo "Installing dconf-cli"
    sudo apt-get install dconf-cli
  else
    echo -e "${RED} Unknown OS_NAME ${NC}"
  fi
}

InstallGogh() {
  # Install different GNOME terminal themes.
  # TODO: Set defaults, check to see if themes alaready downloaded
  wget -O xt  http://git.io/v3D4z && chmod +x xt && ./xt && rm xt
  wget -O xt  https://git.io/v5mPp && chmod +x xt && ./xt && rm xt
}

main() {
  if ! GetDistroVersion; then
    exit 1
  fi
  InstallTmuxPluginManager

  if [ ${OS_NAME} != "Mac" ]; then
    InstallDconfCli
    InstallGogh
  fi
}

main
