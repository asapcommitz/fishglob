if status is-interactive
    bind \r __fishglob_expand_command_line
    bind enter __fishglob_expand_command_line
end

function _fishglob_uninstall --on-event fishglob_uninstall
    bind -e \r
    bind -e enter
end
u