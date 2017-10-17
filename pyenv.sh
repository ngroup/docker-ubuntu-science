#!/bin/bash

curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash && \

pyenv update
pyenv install 3.6.3
pyenv virtualenv 3.6.3 science
