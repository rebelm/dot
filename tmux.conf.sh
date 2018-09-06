################################################
# Begin apply_general
apply_general() {
    # Use pmset as an indicator that this is on macos and that tmux is running locally
    which pmset > /dev/null 2>&1
    if [ $is_local -eq 0 ]
    then
        ${tmux} set-option -g prefix C-s
    else
        ${tmux} set-option -g prefix C-q
    fi

    # Fix SSH agent when tmux is detached
    ${tmux} set-environment -g SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock

    ${tmux} set-option -g history-limit 100000              # History to almost the beginning of time

    ${tmux} set-option -g set-titles on                     # Set title of terminal window
    ${tmux} set-option -g set-titles-string "#S"            # to the name to the session

    ${tmux} bind-key n next-window
    ${tmux} bind-key l last-window                          # Select previous window
#    ${tmux} bind-key C-q last-window                          # Select previous window

    ${tmux} bind-key { swap-pane -U
    ${tmux} bind-key } swap-pane -D

    ${tmux} bind-key C-h resize-pane -L 5                   # Move pane divider left
    ${tmux} bind-key C-j resize-pane -D 5                   # Move pane divider down
    ${tmux} bind-key C-k resize-pane -U 5                   # Move pane divider up
    ${tmux} bind-key C-l resize-pane -R 5                   # Move pane divider right

    ${tmux} set-option -g status-justify left               # Left-justify the window list
    ${tmux} set-option -g status-left-length 30             # Allow for longer session names
    ${tmux} set-option -g status-right-length 100           # Lots of crap go here

    # TODO:  Gnome Terminal on Ubuntu doesn't like xterm-256color
    ${tmux} set-option -g default-terminal "xterm-256color"
#    ${tmux} set-option -g default-terminal "xterm"

    ${tmux} set-option -g base-index 1                      # Window numbering starts at 1
    ${tmux} set-window-option -g pane-base-index 1          # Pane numbering starts at 1
    ${tmux} set-option -g renumber-windows on               # Keep windows sequentially numbered

    ${tmux} bind-key R source ~/.tmux.conf \; display-message "Configuration reloaded"

    ${tmux} bind-key S set-window-option synchronize-panes  # Input goes to all panes simultaneously à la cssh

    ${tmux} bind-key P move-window -t lru \; switch-client -t work
    ${tmux} bind-key O move-window -t work \; switch-client -t lru
#    ${tmux} bind-key M set-window-option monitor-activity off \; 
#        display-message "Enable monitor-activity on window #{window_index}:#{window_name} #{?monitor_activity,<--,uuu}"
#    bind-key M set-window-option monitor-activity on \; \
#        display-message "Enable monitor-activity on window #{window_index}:#{window_name}"
#    bind-key m set-window-option monitor-activity off \; \
#        display-message "Disable monitor-activity on window #{window_index}:#{window_name}"

    # vim style copy paste
    ${tmux} set-window-option -g mode-keys vi               # vim-style movement
    # in normal tmux mode
    ${tmux} bind-key Escape copy-mode                       # Starts copy mode.
    ${tmux} bind-key p paste-buffer                         # Paste the latest buffer

    # in copy mode
    ${tmux} bind-key -t vi-copy v begin-selection           # Begin a selection
    ${tmux} bind-key -t vi-copy y copy-selection            # Yank
    ${tmux} bind-key -t vi-copy V rectangle-toggle          # Line / column selection toggle
    ${tmux} bind-key -t vi-copy Y copy-end-of-line          # ^1
    ${tmux} bind-key + delete-buffer

    # choose-tree format
    ${tmux} bind-key s choose-tree -u -W "#{window_index}:#{window_name} (#{window_panes}) #{?window_active,✔,}"
    ${tmux} bind-key x confirm-before -p "kill-pane #P? (y/n)" kill-pane
}
# End apply_general
################################################

################################################
# Begin apply_color
apply_color() {
    ${tmux} set-option status-bg black
    ${tmux} set-option -g window-status-separator ''

    tmp=""
    tmp="${tmp}#{?client_prefix,"
    tmp="${tmp}#[fg=white bold bg=#ff0000] [#{session_name}] ,"
    tmp="${tmp}#[fg=white bold bg=black] [#{session_name}] }"
    ${tmux} set-option -g status-left "${tmp}"

    tmp=""
    tmp="${tmp}#[fg=white bold bg=black] #{window_index}:#{window_name} "
    ${tmux} set-option -g window-status-format "${tmp}"

    tmp=""
    tmp="${tmp}#{?window_zoomed_flag,"
    tmp="${tmp}#[fg=white bold bg=#ff0000] #{window_index}:#{window_name} "
    tmp="${tmp},#{?pane_synchronized,"
    tmp="${tmp}#[fg=white bold bg=blue]|#{window_index}:#{window_name}|,"
    tmp="${tmp}#[fg=white bold bg=blue] #{window_index}:#{window_name} }"
    tmp="${tmp}}"
    ${tmux} set-option -g window-status-current-format "${tmp}"

    ${tmux} set-option -g status-right "#[fg=white bold bg=black] #H #(date +'%H:%M %Y-%m-%d') "

# pane border
    ${tmux} set-option -g pane-border-fg "#000000"
    ${tmux} set-option -g pane-active-border-fg "#ffff00"

# message line
    ${tmux} set-option -g message-bg "white"
    ${tmux} set-option -g message-fg "black"
}
# End apply_color
################################################



################################################
# Begin Apply
apply() {
    set
    tmux="tmux"

#    solarized_mode=$(readlink ~/.tmux-solarized | awk -F '-' '{print $NF}')
#    get_nestedness
    apply_general
    apply_color
}
# End Apply
################################################

$@

