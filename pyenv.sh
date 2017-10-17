#!/bin/bash

curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
echo 'export PATH="/home/'${user}'/.pyenv/bin:$PATH"' >> /home/${user}/.bashrc
echo 'eval "$(pyenv init -)"' >> /home/${user}/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> /home/${user}/.bashrc
