#/bin/bash

dry_run=true
sensitive_dotfiles=(
  "ssh"
  "aws"
  "cloudflared"
  "kube"
)

create_temp_sensitive_dotfiles_folder() {
    if [ -d sensitive_dotfiles ]; then
        echo "sensitive_dotfiles folder already exists"
        exit 1
    fi

    if [ "$dry_run" = true ]; then
        echo "dry_run: mkdir sensitive_dotfiles"
    else
        mkdir sensitive_dotfiles
    fi
}

dump_sensitive_dotfiles() {
    echo "Dumping sensitive dotfiles ..."
    create_temp_sensitive_dotfiles_folder
    for dotfile in "${sensitive_dotfiles[@]}"; do
        if [ ! -f ~/.$dotfile ] && [ ! -d ~/.$dotfile ]; then
            echo "[WARNING] .$dotfile not found, skipping"
            continue
        fi

        if [ "$dry_run" = true ]; then
            echo "dry_run: cp -r ~/.$dotfile sensitive_dotfiles"
            if [ "$dotfile" = "kube" ]; then
                echo "dry_run: rm -r ~/.$dotfile/cache"
            fi
            continue
        fi

        if [ "$dotfile" = "kube" ]; then
            rm -r ~/.$dotfile/cache
        fi
        cp -r ~/.$dotfile sensitive_dotfiles

    done

    if [ "$dry_run" = true ]; then
        echo "dry_run: zip -r sensitive_dotfiles.zip sensitive_dotfiles"
        echo "dry_run: rm -r sensitive_dotfiles"
        return
    else
        zip -r sensitive_dotfiles.zip sensitive_dotfiles
        rm -r sensitive_dotfiles
        echo "Zipped sensitive dotfiles to sensitive_dotfiles.zip"
    fi
}

load_sensitive_dotfiles() {
    if [ ! -f sensitive_dotfiles.zip ]; then
        echo "sensitive_dotfiles.zip not found"
        exit 1
    fi
    echo "Loading sensitive dotfiles ..."
    unzip -o sensitive_dotfiles.zip
    for dotfile in "${sensitive_dotfiles[@]}"; do
        if [ -f ~/.$dotfile -o -d ~/.$dotfile ]; then
            echo "[WARNING] .$dotfile already exists, skipping"
            continue
        fi

        if [ "$dry_run" = true ]; then
            echo "dry_run: cp -r sensitive_dotfiles/.$dotfile ~"
            continue
        fi

        echo "Copying .$dotfile"
        cp -r sensitive_dotfiles/.$dotfile ~
    done

    rm -r sensitive_dotfiles
    echo "All succeeded!"
}

help() {
    echo "Usage: $0 {dump|load} --dry-run={true|false}"
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --dry-run=true) dry_run=true ;;
        --dry-run=false) dry_run=false ;;
        dump) action="dump" ;;
        load) action="load" ;;
        --help|-h) action="help" ;;
        *) echo "Unknown parameter passed: $1"; help; exit 1 ;;
    esac
    shift
done

case $action in
    dump)
        dump_sensitive_dotfiles
        ;;
    load)
        load_sensitive_dotfiles
        ;;
    help)
        help
        ;;
    *)
        help
        exit 1
        ;;
esac