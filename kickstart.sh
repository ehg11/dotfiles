DIR="$HOME/.local/bin"
RC="$HOME/.zshrc"

if command -v apt-get &> /dev/null; then
    PACKAGE_MGR="apt-get"
elif command -v apt &> /dev/null; then
    PACKAGE_MGR="brew"
else
    echo "No supported package managers."
    exit 1
fi
echo "Using package manager $PACKAGE_MGR."

if [ ! -d "$DIR" ]; then
    mkdir -p "$DIR"
fi

cd "$DIR"

yoink_binary() {
    TEMP_DIR=$1
    PACKAGE_NAME=$2

    BIN_PATH=$(find "$TEMP_DIR" -type f -executable | grep -E "$PACKAGE_NAME$" | sort | uniq)
    if [ -z "$BIN_PATH" ]; then
        echo "Executable not found for $PACKAGE_NAME."
        exit 1
    fi

    for BIN in $(find "$BIN_PATH" -type f -executable); do
        mv "$BIN" .
        chmod +x ./$(basename "$BIN")
        echo "$PACKAGE_NAME successfully added."
    done

    rm -r "$TEMP_DIR"
}

apt_download() {
    PACKAGE_NAME=$1
    echo "Downloading $PACKAGE_NAME with apt-get..."

    # apt-get download goes to current directory
    # this helps avoid using sudo
    apt-get -qq download "$PACKAGE_NAME"

    if [ $? -eq 0 ]; then
        echo "$PACKAGE_NAME was successfully downloaded."
    else
        echo "Failed to download $PACKAGE_NAME."
        exit 1
    fi

    DEB_FILE=$(ls *.deb | grep "$PACKAGE_NAME")
    TEMP_DIR=$(mktemp -d)
    dpkg-deb -x "$DEB_FILE" "$TEMP_DIR"

    yoink_binary "$TEMP_DIR" "$PACKAGE_NAME"

    rm "$DEB_FILE"
}

brew_download() {
    PACKAGE_NAME=$1
    echo "Downloading $PACKAGE_NAME with brew..."
    brew install "$PACKAGE_NAME"

    if [ $? -eq 0 ]; then
        echo "$PACKAGE_NAME was successfully downloaded."
    else
        echo "Failed to download $PACKAGE_NAME."
        exit 1
    fi
}

download() {
    MGR=$1
    PKG=$2

    case $MGR in
        brew)
            brew_download "$PKG"
            ;;
        apt-get)
            apt_download "$PKG"
            ;;
        *)
            echo "Unsupported package manager: $MGR"
            exit 1
            ;;
    esac
}

# nvim
echo "Downloading nvim from source..."
rm -rf "$DIR/nvim"
curl --silent -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -C . -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
yoink_binary nvim-linux64 nvim
# echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> "$RC"

# tmux
rm -rf "$DIR/tmux"
download "$PACKAGE_MGR" tmux

# lazygit
echo "Downloading lazygit from source..."
rm -rf "$DIR/lazygit"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl --silent -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
mkdir lazygit-install-dir
tar xf lazygit.tar.gz -C lazygit-install-dir
yoink_binary lazygit-install-dir lazygit
rm lazygit.tar.gz

# add to path
echo "Adding $DIR to \$PATH..."
export PATH="$PATH:$DIR"
echo "New \$PATH: $PATH."
