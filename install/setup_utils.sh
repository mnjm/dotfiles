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
    [ -d "$lcl" ] || mkdir -p "$lcl"
    git -C "$lcl" pull || git clone "$rmt" "$lcl"
}

stow-dotfiles() {
    app=$1
    op=${2:-"stow"}
    src=$DOTFILES
    tgt=$HOME

    appPath=$src/$app
    if [ ! -d "$appPath" ]; then
        _alert_local "dotfiles for $app couldnt be found" 1
        return 13;
    fi

    case $op in
        stow) flag="--stow" ;;
        unstow) flag="--delete" ;;
        restow) flag="--restow" ;;
        *) ;;
    esac

    if [ -z "$flag" ]; then
        _alert_local "Unknown operation" 1
        return 12;
    fi


    # Link the first level of config files
    stow -v $flag --dir=$src --target=$tgt --no-folding --dotfiles --ignore='dot-config/*' $app
    # Link the second level of config files
    if [ -d "$appPath/dot-config/$app" ]; then
        src=$appPath/dot-config
        tgt=$HOME/.config/$app
        [ -d "$tgt" ] || mkdir -p $tgt
        stow -v $flag --dir=$src --target=$tgt --no-folding --dotfiles $app
    fi
    unset app flag op src tgt appPath
}
