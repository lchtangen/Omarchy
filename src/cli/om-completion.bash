# bash completion for om CLI
_om_completion() {
    local cur prev commands subcommands
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    commands="catalog theme system status update extract version install help"

    if [[ $COMP_CWORD -eq 1 ]]; then
        COMPREPLY=($(compgen -W "$commands" -- "$cur"))
        return 0
    fi

    case "${COMP_WORDS[1]}" in
        catalog|cat)
            subcommands="list search show recommend browse stats help"
            if [[ $COMP_CWORD -eq 2 ]]; then
                COMPREPLY=($(compgen -W "$subcommands" -- "$cur"))
            elif [[ "${COMP_WORDS[2]}" == "list" || "${COMP_WORDS[2]}" == "l" ]]; then
                local cats="themes/gui-apps themes/waybar themes/colorschemes themes/gtk tools configs curated related"
                COMPREPLY=($(compgen -W "$cats" -- "$cur"))
            elif [[ "${COMP_WORDS[2]}" == "show" || "${COMP_WORDS[2]}" == "view" ]]; then
                local repos
                repos=$(find -L "${OM_ROOT:-$PWD}/repos" -name '.git' -type d -exec dirname {} \; 2>/dev/null | xargs -I{} basename {} | sort -u)
                COMPREPLY=($(compgen -W "$repos" -- "$cur"))
            fi
            ;;
        theme|th)
            subcommands="list set current install remove preview help"
            if [[ $COMP_CWORD -eq 2 ]]; then
                COMPREPLY=($(compgen -W "$subcommands" -- "$cur"))
            elif [[ "${COMP_WORDS[2]}" == "set" || "${COMP_WORDS[2]}" == "apply" ]]; then
                local themes_dir="${OMARCHY_THEME_DIR:-$HOME/.config/omarchy/themes}"
                if [[ -d "$themes_dir" ]]; then
                    local themes
                    themes=$(ls -1 "$themes_dir" 2>/dev/null)
                    COMPREPLY=($(compgen -W "$themes" -- "$cur"))
                fi
            elif [[ "${COMP_WORDS[2]}" == "remove" || "${COMP_WORDS[2]}" == "rm" ]]; then
                local themes_dir="${OMARCHY_THEME_DIR:-$HOME/.config/omarchy/themes}"
                if [[ -d "$themes_dir" ]]; then
                    local themes
                    themes=$(ls -1 "$themes_dir" 2>/dev/null)
                    COMPREPLY=($(compgen -W "$themes" -- "$cur"))
                fi
            fi
            ;;
        system|sys)
            subcommands="info health stabilize reload guard help"
            if [[ $COMP_CWORD -eq 2 ]]; then
                COMPREPLY=($(compgen -W "$subcommands" -- "$cur"))
            fi
            ;;
    esac
    return 0
}
complete -F _om_completion om