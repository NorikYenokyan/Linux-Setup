if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

#source /etc/bash_completion.d/git
function timer_start {                                                      
    timer=${timer:-$SECONDS}                                                
}                                                                           

function timer_stop {                                                       
    secs=$(($SECONDS - $timer))                                             
    second=$(($secs%60))
    minute=$(($secs%3600/60))
    hour=$(($secs%86400/3600))
    day=$(($secs/86400))

    unset timer_show 
    if [ $day -gt 0 ]; then
        timer_show=`printf '%dd:%dh:%dm:%ds:' $day $hour $minute $second`
    elif [ $hour -gt 0 ]; then
        timer_show=`printf '%dh:%dm:%ds:' $hour $minute $second`
    elif [ $minute -gt 0 ]; then                                        
        timer_show=`printf '%dm:%ds:' $minute $second`
    elif [ $second -gt 0 ]; then                                        
        timer_show=`printf '%ds:' $second`
    fi
    unset timer
}   

trap 'timer_start' DEBUG                                                    

if [ "$PROMPT_COMMAND" == "" ]; then                                        
    PROMPT_COMMAND="timer_stop" 
else
    PROMPT_COMMAND="$PROMPT_COMMAND; timer_stop"                            
fi  

#PS1='\[\033[38;5;196m\]\w\[\033[38;5;21m\]\$\[\033[38;5;178m\]$timer_show:\[\033[0m\]'
PS1='\[\033[38;5;196m\]\w\[\033[38;5;21m\]\$\[\033[38;5;178m\]:$(git branch 2>/dev/null | grep "^*" | colrm 1 2):$timer_show\[\033[0m\]'
#PS1='\[\033[38;5;196m\]\w\[\033[38;5;21m\]\$\[\033[38;5;178m\]:$(__git_ps1)$timer_show\[\033[0m\]'

#export PROMPT_COMMAND='history -a; history -r'
export HISTSIZE=10000
export HISEFILESIZE=10000
alias d='cd /mnt/c/Users/NORIKY/Desktop'

alias c='clear'
alias q='exit'
alias r='reset'

alias v='vim'
alias gv='gvim'

alias ll='ls -lF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

extract()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xvjf $1 ;;
            *.tar.gz) tar xvzf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) unrar x $1 ;;
            *.gz) gunzip $1 ;;
            *.tar) tar xvf $1 ;;
            *.tbz2) tar xvjf $1 ;;
            *.tgz) tar xvzf $1 ;;
            *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *.7z) 7z x $1 ;;
            *) echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

function g () 
{
    grep "$1" -${3:-rn} ${2:-.} 
}

export VISUAL=vim
export EDITOR="$VISUAL"

