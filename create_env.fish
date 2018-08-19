#!/bin/fish

argparse 'h/help' 'u/user=' 'g/group=' -- $argv

if set -q _flag_h
    string trim '
    h: help
    u: user you want to add
    g: group of user you want to add
    '
end

if set -q _flag_u
    if set -q _flag_g
        useradd $_flag_u
    else
        useradd $_flag_u -g $_flag_g
    end
end
