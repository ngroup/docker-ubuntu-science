#!/bin/bash

pyenv update
pyenv install 3.6.3
pyenv virtualenv 3.6.3 science
pyenv global science
pip install -U setuptools
pip install -U pip
pip install numpy scipy matplotlib ipython sympy pandas networkx tiny2d
touch  ~/.config/matplotlib/matplotlibrc
echo 'backend : Agg' >> ~/.config/matplotlib/matplotlibrc
