#!/usr/bin/fish

# Create environment
#
# @return [None]
#
function create_env
    argparse -n create_env 'h/help' 'u/user=' 'g/group=' 's/shell=' -- $argv

    # show help
    if set -lq _flag_h
        show_help
        return
    end

    # create user
    # https://stackoverflow.com/questions/52025906/can-function-get-empty-arguments
    create_user "$_flag_u" "$_flag_g" "$_flag_s"
end

# Show help information
#
# @return [String] help information
#
function show_help
    string trim '
h: help
u: user you want to add
g: group of user you want to add
s: login shell
'
end

# Create user
#
# @param [String] user  user name
# @param [String] group group name
# @param [String] shell login shell
# @return [None]
#
function create_user -a user group shell
    set -l useradd_opts ''
    set -l separator ' '

    # TODO(from fish 3.0)
    # https://github.com/fish-shell/fish-shell/issues/1326

    if test -n $user
        set useradd_opts $user
    else
        echo 'u/user is required.'
        exit
    end
    if test -n $group
        set useradd_opts (string join $separator -- $useradd_opts -g $group)
    end
    if test -n $shell
        set useradd_opts (string join $separator -- $useradd_opts -s $shell)
    end

    useradd (string split $separator $useradd_opts)
    passwd $user
end

create_env $argv


