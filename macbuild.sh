#!/bin/bash

macbuild_dir=~/git/macbuild

# Prompt the user for their sudo password
sudo -v

# Enable passwordless sudo for the macbuild run
sudo sed -i -e "s/^%admin.*/%admin  ALL=(ALL) NOPASSWD: ALL/" /etc/sudoers

# Install Homebrew
if ! which brew > /dev/null 2>&1
then
    echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
fi

# Install Python
if ! brew list python > /dev/null 2>&1
then
    echo "Installing Python 2.x"
    brew install python
fi

# Install Mercurial
if ! brew list mercurial > /dev/null 2>&1
then
    echo "Installing Mercurial"
    brew install mercurial
fi

# Download Ansible
if [ ! -d ~/git/ansible ];
then
  echo "Download Ansible"
  git clone git://github.com/ansible/ansible.git --recursive ~/git/ansible
fi

if [ ! -f ~/.ssh/id_rsa ]; then
    echo "Generate ssh identity"
    ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
    ssh-add ~/.ssh/id_rsa
    echo "Go to bitbucket.org and add the SSH key"
    cat ~/.ssh/id_rsa.pub
fi

if [ ! -f ~/.hgrc ]; then
  echo "Copy .hgrc"
  cp ${macbuild_dir}/hgrc ~/.hgrc
fi


# Install Ansible (using pip is the officially supported way)
# if ! pip2 show ansible > /dev/null 2>&1
# then
#     echo "Installing Ansible"
#     pip2 install ansible
# fi
#
# # Install biplist to allow manipulation of plist files
# if ! pip2 show biplist > /dev/null 2>&1
# then
#     echo "Installing biplist"
#     pip2 install biplist
# fi
#
# # Perform the build
# ansible-playbook -i localhost, -e ansible_python_interpreter=/usr/local/bin/python local.yml
#
# # Set Terminal settings
# ./terminal.js

# Disable passwordless sudo after the macbuild is complete
sudo sed -i -e "s/^%admin.*/%admin  ALL=(ALL) ALL/" /etc/sudoers
