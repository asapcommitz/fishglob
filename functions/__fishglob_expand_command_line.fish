function __fishglob_expand_command_line
    set -l cmd (commandline -b)
    if string match -qr '[\*\?\{\}\!]' "$cmd"
        set -l words (string split -n ' ' $cmd)
        set -l new_cmd
        for word in $words
            if string match -qr '[\*\?\{\}\!]' "$word"
                set -a new_cmd (__fishglob_translate "$word")
            else
                set -a new_cmd "$word"
            end
        end
        commandline -r (string join ' ' $new_cmd)
    end
    commandline -f execute
end
