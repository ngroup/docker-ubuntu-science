#!/bin/bash

pyenv update
pyenv install 3.6.3
pyenv virtualenv 3.6.3 science
pyenv global science
pyenv activate science
