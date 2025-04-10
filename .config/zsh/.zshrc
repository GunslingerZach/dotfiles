# Luke's config for the Zoomer Shell
fastfetch

export MANPAGER="nvim +Man!"
# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"
# [ -f "${XDG_CONFIG_HOME:-$HOME/.config/shell/profile}" ] && source "${XDG_CONFIG_HOME:-$HOME/.config/shell/profile}"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' '^ulfcd\n'
bindkey -s '^a' '^ubc -lq\n'
bindkey -s '^x' '^ueza -f | fzf | xargs -I{} xdg-open {}\n'
bindkey -s '^r' '^ueza -f | fzf | xargs -I{} ripdrag {}\n'
bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# function preexec() {
#   timer=${timer:-$SECONDS}
# }

# function precmd() {
#   if [ $timer ]; then
#     timer_show=$(($SECONDS - $timer))
#     export RPROMPT="%F{cyan}${timer_show}s %{$reset_color%}"
#     unset timer
#   fi
# }
function preexec() {
 timer=$(date +%s%3N)
}

function precmd() {
if [ $timer ]; then
local now=$(date +%s%3N)
local d_ms=$(($now-$timer))
local d_s=$((d_ms / 1000))
local ms=$((d_ms % 1000))
local s=$((d_s % 60))
local m=$(((d_s / 60) % 60))
local h=$((d_s / 3600))
if ((h > 0)); then elapsed=${h}h${m}m
elif ((m > 0)); then elapsed=${m}m${s}s
elif ((s >= 10)); then elapsed=${s}.$((ms / 100))s
elif ((s > 0)); then elapsed=${s}.$((ms / 10))s
else elapsed=${ms}ms
fi

export RPROMPT="%F{cyan}${elapsed} %{$reset_color%}"
unset timer
fi
}

# Load plugins; should be last.
zsh_plugin_dir="/usr/share/zsh/plugins/"
source $zsh_plugin_dir/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $zsh_plugin_dir/zsh-autosuggestions/zsh-autosuggestions.zsh
# source $zsh_plugin_dir/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $zsh_plugin_dir/fzf-tab/fzf-tab.plugin.zsh
