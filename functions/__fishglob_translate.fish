function __fishglob_translate
    set -l input $argv
    set -l translated_args

    for arg in $input
        set -l expansion_pool $arg
        if string match -q "*{*,*}*" "$arg"
            set -l escaped (string replace -a '*' '\\*' "$arg")
            set expansion_pool (eval echo $escaped 2>/dev/null; or echo $arg)
            set expansion_pool (string replace -a '\\*' '*' $expansion_pool)
        end

        for item in $expansion_pool
            set -l translated (string replace -r '!\((.*?)\)' '(not $1)' "$item")
            set translated (string replace -a '**/*.' '**.' "$translated")
            set translated (string replace -a '**/*/' '**' "$translated")
            set translated (string replace -ra '/+' '/' "$translated")
            set -a translated_args "$translated"
        end
    end
    echo (string join ' ' $translated_args)
end
