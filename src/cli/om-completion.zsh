#compdef om

_om() {
    local curcontext="$curcontext" state line
    typeset -A opt_args

    _arguments -C \
        '1:command:->command' \
        '*::arg:->arg'

    case $state in
        command)
            _values 'om commands' \
                'catalog[Browse and search the repo catalog]' \
                'theme[Theme management]' \
                'system[System management]' \
                'lab[Repo-mined ideas and tools]' \
                'labs[Repo-mined ideas and tools]' \
                'tui[Interactive dashboard]' \
                'dashboard[Interactive dashboard]' \
                'status[Show project overview]' \
                'update[Pull latest from all repos]' \
                'extract[Extract assets from repos]' \
                'version[Show version]' \
                'install[Install om CLI to /usr/local/bin]' \
                'help[Show help]'
            ;;
        arg)
            case $words[1] in
                catalog|cat)
                    case $words[2] in
                        list|l)
                            _values 'categories' 'themes/gui-apps' 'themes/waybar' 'themes/colorschemes' 'themes/gtk' 'tools' 'configs' 'curated' 'related'
                            ;;
                        show|view)
                            _message 'repo name'
                            ;;
                        *)
                            _values 'catalog subcommands' 'list[List repos]' 'search[Search repos]' 'show[Show repo details]' 'recommend[Recommend repos]' 'browse[Interactive browser]' 'stats[Catalog statistics]'
                            ;;
                    esac
                    ;;
                theme|th)
                    case $words[2] in
                        set|apply|remove|rm)
                            _message 'theme name'
                            ;;
                        *)
                            _values 'theme subcommands' 'list[List themes]' 'set[Apply theme]' 'current[Show active theme]' 'install[Install from git]' 'remove[Remove theme]' 'preview[Preview theme]'
                            ;;
                    esac
                    ;;
                system|sys)
                    _values 'system subcommands' 'info[System info]' 'health[Health check]' 'diagnose[Runtime diagnostics]' 'diag[Runtime diagnostics]' 'stabilize[Stabilize session]' 'reload[Reload services]' 'guard[Start guard]'
                    ;;
                lab|labs)
                    _values 'lab subcommands' 'ideas[List feature ideas]' 'show[Show idea]' 'tools[List tool repos]' 'tool[Show one tool]' 'repos[List cloned repos]' 'search[Search ideas/readmes]' 'runway[Release runway]'
                    ;;
            esac
            ;;
    esac
}

_om "$@"
