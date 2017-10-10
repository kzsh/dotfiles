#!/bin/bash

#allow chunkwm to pass through ctrl-h/j/k/l so that vim can switch panes without triggering shell escape characters

bind -x '"\C-l":'
bind -x '"\C-h":'
bind -x '"\C-j":'
bind -x '"\C-k":'
