# $Id: vim-keys.conf,v 1.2 2010/09/18 09:36:15 nicm Exp $
#
# vim-keys.conf, v1.2 2010/09/12
#
# By Daniel Thau.  Public domain.
#
# This configuration file binds many vi- and vim-like bindings to the
# appropriate tmux key bindings.  Note that for many key bindings there is no
# tmux analogue.  This is intended for tmux 1.3, which handles pane selection
# differently from the previous versions

#set prefix key (be vimlike)
unbind C-b
set -g prefix C-f
bind C-f send-prefix

set status-utf8 on
set utf8 on

# split windows like vim
# vim's definition of a horizontal/vertical split is reversed from tmux's
bind s split-window -v
bind v split-window -h

bind C-h select-window -t :-
bind C-l select-window -t :+

bind h select-window -t :-
bind l select-window -t :+

set -sg escape-time 0

# Smart pane switching with awareness of vim splits
is_vim='echo "#{pane_current_command}" | grep -iqE "(^|\/)g?(view|n?vim?)(diff)?$"'

#unbind-key C-h
#unbind-key C-j
#unbind-key C-k
#unbind-key C-l

bind -n C-h if-shell "$is_vim" "send-keys C-h" "select-pane -L"
bind -n C-j if-shell "$is_vim" "send-keys C-j" "select-pane -D"
bind -n C-k if-shell "$is_vim" "send-keys C-k" "select-pane -U"
bind -n C-l if-shell "$is_vim" "send-keys C-l" "select-pane -R"
bind -n C-\ if-shell "$is_vim" "send-keys C-\\" "select-pane -l"


# resize panes like vim
# feel free to change the "1" to however many lines you want to resize by, only
# one at a time can be slow
bind < resize-pane -L 10
bind > resize-pane -R 10
bind - resize-pane -D 10
bind + resize-pane -U 10

# bind : to command-prompt like vim
# this is the default in tmux already
bind : command-prompt

# vi-style controls for copy mode
setw -g mode-keys vi

set-window-option -g mode-mouse on
set-option -g mouse-select-pane on
set-option -g mouse-select-window on

set -g default-terminal "xterm-256color"
set -ga terminal-overrides 'xterm*:smcup@:rmcup@'

set-option -g history-limit 100000

bind-key R respawn-window

# create a session with a throw-away window
new true
#
# # for future windows, stay open after the command exits
#set set-remain-on-exit on
#
# # create the windows we really want
neww -n vim
splitw -v -p 20 -t 0
#
# # for future windows, revert r-o-e to global value
set -u set-remain-on-exit

#
# Bring back clear screen under tmux prefix
bind C-l send-keys 'C-l'

# Start windows and panes at 1, not 0
set -g base-index 1
set -g pane-base-index 1

# move x clipboard into tmux paste buffer
bind C-p run "tmux set-buffer \"$(xclip -o)\"; tmux paste-buffer"

set-window-option -g status-bg colour237
set-window-option -g status-fg colour255
set-window-option -g window-status-current-bg colour166

# in normal tmux mode
bind Escape copy-mode # `tmux prefix + Escape` starts copy mode.
bind p paste-buffer # `prefix + p` pastes the latest buffer

# in copy mode…
bind -t vi-copy v begin-selection # `v` begins a selection. (movement keys to select the desired bits)
bind -t vi-copy y copy-selection # `y` copies the current selection to one of tmux's "paste buffers"
bind -t vi-copy V rectangle-toggle # `V` changes between line- and columnwise selection

bind -t vi-copy Y copy-end-of-line # ^1
bind + delete-buffer




## move tmux copy buffer into x clipboard
#bind C-y run "tmux save-buffer - | xclip -i"

# Copy-paste integration
# must have `brew install reattach-to-user-namespace`
set-option -g default-command "reattach-to-user-namespace -l bash"
#set-option -g default-command "reattach-to-user-namespace -l zsh"

## Setup 'v' to begin selection as in Vim
bind-key -t vi-copy v begin-selection
bind-key -t vi-copy y copy-pipe "reattach-to-user-namespace pbcopy"

## Update default binding of `Enter` to also use copy-pipe
#unbind -t vi-copy Enter
#bind-key -t vi-copy Enter copy-pipe "reattach-to-user-namespace pbcopy"

set-option -g default-shell /bin/bash
