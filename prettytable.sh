#!/bin/bash

####
# Copyright (c) 2016, 
#   Jakob Westhoff <jakob@westhoffswelt.de>
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
#  - Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
#  - Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUsed AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVIsed OF THE POSSIBILITY OF SUCH DAMAGE.
####

_prettytable_top_left="┌"
_prettytable_horizontal="─"
_prettytable_vertical="│"
_prettytable_bottom_left="└"
_prettytable_bottom_right="┘"
_prettytable_top_right="┐"
_prettytable_vertical_horizontal_left="├"
_prettytable_vertical_horizontal_right="┤"
_prettytable_vertical_horizontal_top="┬"
_prettytable_vertical_horizontal_bottom="┴"
_prettytable_vertical_horizontal="┼"

function _prettytable_prettify_lines() {
    cat - | sed -e "s@^@${_prettytable_vertical}@;s@\$@	@;s@	@	${_prettytable_vertical}@g"
}

function _prettytable_fix_border_lines() {
    cat - | sed -e "1s@ @${_prettytable_horizontal}@g;3s@ @${_prettytable_horizontal}@g;\$s@ @${_prettytable_horizontal}@g"
}

function prettytable() {
    local cols="${1}"
    local input="$(cat -)"
    local header="$(echo -e "${input}"|head -n1)"
    local body="$(echo -e "${input}"|tail -n+2)"
    {
        # Top border
        echo -n "${_prettytable_top_left}"
        for i in $(seq 2 ${cols}); do
            echo -ne "\t${_prettytable_vertical_horizontal_top}"
        done
        echo -e "\t${_prettytable_top_right}"

        echo -e "${header}" | _prettytable_prettify_lines

        # Header/Body delimiter
        echo -n "${_prettytable_vertical_horizontal_left}"
        for i in $(seq 2 ${cols}); do
            echo -ne "\t${_prettytable_vertical_horizontal}"
        done
        echo -e "\t${_prettytable_vertical_horizontal_right}"

        echo -e "${body}" | _prettytable_prettify_lines

        # Bottom border
        echo -n "${_prettytable_bottom_left}"
        for i in $(seq 2 ${cols}); do
            echo -ne "\t${_prettytable_vertical_horizontal_bottom}"
        done
        echo -e "\t${_prettytable_bottom_right}"
    } | column -t -s $'\t' | _prettytable_fix_border_lines
}

case $- in
  *i*) ;; # assume being sourced, do nothing
  *) prettytable ;; # assume being executed as an executable
esac

