# take = mkdir + pushd
take() {
    mkdir -p $1
    pushd $1
}

_alert_local() {
    color=${2:-6}
    tput setaf $color; echo $1; tput sgr0
}

_download_install_deb() {
    # AGRGS
    name=$1
    url=$2
    downloadto="$HOME/softwares"

    urltail=${url##*/}
    lclfile="$downloadto/$urltail"
    # echo $name $url $urltail #lclfile
    
    mkdir -p $downloadto
    curl -kL $url --output $lclfile || _alert_local "$name download failed" 1
    sudo dpkg -i $lclfile || _alert_local "$name install failed" 1
}

_path_add() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

_source_if_file_exists_err() {
    if [ -f "$1" ]; then
        source $1
    else
        _alert_local "File $1 doenst exists" 1
    fi
}

_source_if_file_exists() {
    if [ -f "$1" ]; then
        source $1
    fi
}

_link_file() {
    src=$(readlink -f $1)
    dst=$2
    if [ -f "$dst" ]; then
        rdst=$(readlink -f "$dst") # resolve the $dst link
        if [ "$src" != "$rdst" ]; then
            _alert_local "Cant link $src to $dst. Checkout below for more info" 1
            ls -l $dst
        fi
    else
        ln -vs $src $dst || ls -l $dst
    fi
}

_git_clone_pull() {
    rmt=$1
    lcl=$2
    git -C "$lcl" pull || git clone "$rmt" "$lcl"
}

stow-dotfiles() {
    stow -v --dir=$DOTFILES --target=$HOME --no-folding $1
}
