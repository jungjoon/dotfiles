#!/usr/bin/env ruby
# simplified __git_ps1
# TODO: implement exact semantics of __git_ps1 => see git-ps1.bash

# color with bolds
COLOR_OFF="\033[0m"
BBLACK="\033[1;30m"
BRED="\033[1;31m"
BGREEN="\033[1;32m"
BYELLOW="\033[1;33m"
BBLUE="\033[1;34m"
BPURPLE="\033[1;35m"
BCYAN="\033[1;36m"
BWHITE="\033[1;37m"

def main
    input = `git status 2>/dev/null`

    branch = "unknown"
    ex_st_mod = false
    ex_unst_mod = false
    ex_unst_add = false

    if input =~ /^$/
        return 0
    end

    if input =~ /^# On branch (.*)/
        branch = $1
    end

    ex_st_mod = (input =~ /^# Changes to be committed/)
    ex_unst_mod = (input =~ /^# Changed but not updated/)
    ex_unst_add = (input =~ /^# Untracked files/)

    # puts ex_st_mod, ex_unst_mod, ex_unst_add

    branch_color = COLOR_OFF
    branch_color = BGREEN if ex_unst_add
    branch_color = BBLUE if ex_st_mod
    branch_color = BRED if ex_unst_mod

    # ?: new file, +: staged mod, *: unstaged mod
    flags = " "
    flags += '+' if ex_st_mod
    flags += '*' if ex_unst_mod
    flags += '?' if ex_unst_add

    flags = "" if flags == " "

    format = ARGV[0] || "%s"

    print format % "#{branch_color}#{branch}#{flags}#{COLOR_OFF}"
end

main
