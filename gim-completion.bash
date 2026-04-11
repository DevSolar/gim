# bash completion for gim

_gim() {
    local cur prev words cword
    _get_comp_words_by_ref -n : cur prev words cword

    local subcommands="add amend bisect blame chmod clone commit diff fetch help info init log merge mkbranch mkpatch mv pull push rebase remote resolve revert rewrite rm rmbranch setup stash status switch tag unstage uncommit update"

    if [ $cword -eq 1 ]; then
        COMPREPLY=( $(compgen -W "$subcommands" -- "$cur") )
        return 0
    fi

    local subcommand="${words[1]}"

    case "$subcommand" in
        add|blame|resolve|unstage)
            _filedir
            ;;
        amend)
            case "$cur" in
                -*) COMPREPLY=( $(compgen -W "--file -F --message -m" -- "$cur") ) ;;
                *) _filedir ;;
            esac
            ;;
        bisect)
            local sub="start new old skip end"
            if [ $cword -eq 2 ]; then
                COMPREPLY=( $(compgen -W "$sub" -- "$cur") )
            else
                case "${words[2]}" in
                    start|new|old|skip)
                        COMPREPLY=( $(compgen -W "$(git rev-parse --symbolic --branches --tags --remotes 2>/dev/null)" -- "$cur") )
                        ;;
                    end)
                        COMPREPLY=( $(compgen -W "- current" -- "$cur") )
                        ;;
                esac
            fi
            ;;
        chmod)
            if [ $cword -eq 2 ]; then
                COMPREPLY=( $(compgen -W "+x -x" -- "$cur") )
            else
                _filedir
            fi
            ;;
        clone)
            _filedir
            ;;
        commit)
            case "$cur" in
                -*) COMPREPLY=( $(compgen -W "--amend --patch --file -F --message -m" -- "$cur") ) ;;
                *) _filedir ;;
            esac
            ;;
        diff)
            case "$cur" in
                *)
                    COMPREPLY=( $(compgen -W "$(git rev-parse --symbolic --branches --tags --remotes 2>/dev/null)" -- "$cur") )
                    _filedir
                    ;;
            esac
            ;;
        fetch)
            case "$cur" in
                -*) COMPREPLY=( $(compgen -W "--quiet -q" -- "$cur") ) ;;
                *) COMPREPLY=( $(compgen -W "$(git remote)" -- "$cur") ) ;;
            esac
            ;;
        help)
            local topics="intro simplicity safety navigation rewrite workflows topics"
            COMPREPLY=( $(compgen -W "$subcommands $topics" -- "$cur") )
            ;;
        info)
            case "$cur" in
                -*) COMPREPLY=( $(compgen -W "--verbose -v" -- "$cur") ) ;;
                *) COMPREPLY=( $(compgen -W "$(git remote)" -- "$cur") ) ;;
            esac
            ;;
        init)
            case "$cur" in
                -*) COMPREPLY=( $(compgen -W "--local -l --bare -b" -- "$cur") ) ;;
                *) _filedir -d ;;
            esac
            ;;
        log)
            case "$cur" in
                -*) COMPREPLY=( $(compgen -W "--all -a --short -s --medium -m --long -l --verbose -v --reference -r --graph -g" -- "$cur") ) ;;
                *) COMPREPLY=( $(compgen -W "$(git rev-parse --symbolic --branches --tags --remotes 2>/dev/null)" -- "$cur") ) ;;
            esac
            ;;
        merge|mkbranch|rebase|rewrite)
            COMPREPLY=( $(compgen -W "$(git branch --format='%(refname:short)')" -- "$cur") )
            ;;
        mkpatch)
            _filedir
            ;;
        mv)
            _filedir
            ;;
        pull)
            COMPREPLY=( $(compgen -W "$(git remote)" -- "$cur") )
            ;;
        push)
            case "$prev" in
                --to|-t)
                    COMPREPLY=( $(compgen -W "$(git remote)" -- "$cur") )
                    return 0
                    ;;
            esac
            case "$cur" in
                -*) COMPREPLY=( $(compgen -W "--to -t --force -f" -- "$cur") ) ;;
                *) COMPREPLY=( $(compgen -W "$(git remote)" -- "$cur") ) ;;
            esac
            ;;
        remote)
            local sub="add remove rename"
            if [ $cword -eq 2 ]; then
                COMPREPLY=( $(compgen -W "$sub" -- "$cur") )
            else
                case "${words[2]}" in
                    remove|rename)
                        COMPREPLY=( $(compgen -W "$(git remote)" -- "$cur") )
                        ;;
                esac
            fi
            ;;
        revert)
            case "$cur" in
                -*) COMPREPLY=( $(compgen -W "--clean -c" -- "$cur") ) ;;
                *) _filedir ;;
            esac
            ;;
        rm)
            case "$cur" in
                -*) COMPREPLY=( $(compgen -W "--recurse -r --force -f" -- "$cur") ) ;;
                *) _filedir ;;
            esac
            ;;
        rmbranch)
            case "$prev" in
                --remote|-r)
                    COMPREPLY=( $(compgen -W "$(git remote)" -- "$cur") )
                    return 0
                    ;;
            esac
            case "$cur" in
                -*) COMPREPLY=( $(compgen -W "--remote -r" -- "$cur") ) ;;
                *)
                    COMPREPLY=( $(compgen -W "$(git branch --format='%(refname:short)')" -- "$cur") )
                    ;;
            esac
            ;;
        stash)
            local sub="push list show drop clear apply pop branch"
            if [ $cword -eq 2 ]; then
                COMPREPLY=( $(compgen -W "$sub" -- "$cur") )
            else
                case "${words[2]}" in
                    show|drop|apply|pop|branch)
                        COMPREPLY=( $(compgen -W "$(git stash list | sed -e 's/:.*//')" -- "$cur") )
                        ;;
                esac
            fi
            ;;
        switch)
            case "$cur" in
                -*) COMPREPLY=( $(compgen -W "--detach -d" -- "$cur") ) ;;
                *)
                    if [[ "$prev" == "--detach" || "$prev" == "-d" ]]; then
                        COMPREPLY=( $(compgen -W "$(git rev-parse --symbolic --branches --tags --remotes 2>/dev/null)" -- "$cur") )
                    else
                        COMPREPLY=( $(compgen -W "$(git branch --format='%(refname:short)')" -- "$cur") )
                    fi
                    ;;
            esac
            ;;
        tag)
            local sub="add delete list"
            if [ $cword -eq 2 ]; then
                COMPREPLY=( $(compgen -W "$sub" -- "$cur") )
            else
                case "${words[2]}" in
                    add)
                        case "$cur" in
                            -*) COMPREPLY=( $(compgen -W "--file -F --message -m --light -l" -- "$cur") ) ;;
                            *) COMPREPLY=( $(compgen -W "$(git rev-parse --symbolic --branches --tags --remotes 2>/dev/null)" -- "$cur") ) ;;
                        esac
                        ;;
                    delete)
                        COMPREPLY=( $(compgen -W "$(git tag)" -- "$cur") )
                        ;;
                    list)
                        case "$cur" in
                            -*) COMPREPLY=( $(compgen -W "--all -a" -- "$cur") ) ;;
                        esac
                        ;;
                esac
            fi
            ;;
        uncommit)
            case "$cur" in
                -*) COMPREPLY=( $(compgen -W "--force -f -n" -- "$cur") ) ;;
            esac
            ;;
    esac

    return 0
}

complete -F _gim gim
