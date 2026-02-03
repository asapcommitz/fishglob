function fishglob --description 'Bash/Zsh to Fish glob translator'
    if not set -q argv[1]; or contains -- -h $argv; or contains -- --help $argv
        echo "fishglob: Bash/Zsh to Fish glob translator"
        echo "Usage:"
        echo "  fishglob \"<glob>\"           - Translate glob"
        echo "  fishglob <cmd> \"<glob>\"     - Translate and execute"
        echo ""
        echo "Examples:"
        echo "  fishglob \"**/*.{js,ts}\"     -> **.js **.ts"
        echo "  fishglob ls \"!(test).py\"    -> ls (not test).py"
        return 0
    end

    set -l command_mode 0
    set -l cmd_arr

    if test (count $argv) -gt 1
        set -l first $argv[1]
        if type -q "$first"; or not string match -qr '[\*\?\{\}\!]' "$first"
            set command_mode 1
            set cmd_arr $argv[1]
            set -e argv[1]
        end
    end

    set -l translated (__fishglob_translate $argv)

    if test $command_mode -eq 1
        eval "$cmd_arr $translated"
    else
        echo $translated
    end
end
