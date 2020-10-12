# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ANTIGEN="${HOME}/.local/share/antigen/bin/antigen.zsh"

# Install antigen.zsh if not exist
if [ ! -f "${ANTIGEN}" ]; then
    echo "Install antigen"
    [ ! -d "${HOME}/.local/share" ] && mkdir -p "${HOME}/.local/share" 2>/dev/null

    REPO="https://github.com/zsh-users/antigen.git"
    if [ -x $(which git) ]; then
        git clone --recurse ${REPO} ${HOME}/.local/share/antigen
    else
        echo "ERROR: please install git before installation!!"
    fi

    if [ ! $? -eq 0 ]; then
        echo ""
        echo "ERROR: clone antigen repo (${REPO}) failed!!"
        exit
    fi
fi

# Initialize antigen
source "${ANTIGEN}"


# Decalre modules
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' key-bindings 'emacs'
zstyle ':prezto:module:git:alias' skip 'yes'
# save-ops : default 'yes'
# enable it will make rm alias to rm -i,  prompt before every removal
zstyle ':prezto:module:utility' safe-ops 'no'

# correct : default 'yes'
zstyle ':prezto:module:utility' correct 'no'

zstyle ':prezto:module:prompt' theme 'powerlevel10k'
zstyle ':prezto:module:prompt' pwd-length 'short'
zstyle ':prezto:module:terminal' auto-title 'yes'
zstyle ':prezto:module:autosuggestions' color 'yes'
zstyle ':prezto:module:python' autovenv 'yes'
zstyle ':prezto:load' pmodule \
	'environment' \
	'editor' \
	'history' \
	'git' \
	'utility' \
	'completion' \
	'history-substring-search' \
	'autosuggestions' \
	'prompt' \

# Enable 256 color to make auto-suggestions look nice
export TERM="xterm-256color"

# Initialize prezto
antigen use prezto

# default bundles
# antigen bundle romkatv/powerlevel10k
antigen bundle zdharma/fast-syntax-highlighting
# antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
# antigen bundle rupa/z z.sh  # quick change to directory

antigen apply

# options
setopt completealiases
setopt nocaseglob
setopt sharehistory histignoredups appendhistory

# set history
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# set dir stack
DIRSTACKSIZE=10
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups cdablevars

# Disable correction
unsetopt correctall
unsetopt correct

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
