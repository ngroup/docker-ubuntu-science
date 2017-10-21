#!/bin/bash
curl https://raw.githubusercontent.com/ngroup/tmux-config/master/tmux.config > ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "alias tmux='TERM=xterm-256color tmux'" >> ~/.bashrc
~/.tmux/plugins/tpm/bin/install_plugins
