#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dotfiles"    # Change if your repo lives elsewhere
BACKUP_DIR="$HOME/.dotfiles_backup"
CONFIG_DIR="$HOME/.config"

echo "📦 Installing dotfiles from $DOTFILES_DIR"

# Create backup folder
mkdir -p "$BACKUP_DIR"

link_file() {
    local src=$1
    local dest=$2

    # If the file exists and isn't a symlink, back it up
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "↪ Backing up $dest to $BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/"
    fi

    # Create parent directory if needed
    mkdir -p "$(dirname "$dest")"

    # Create symlink
    ln -sf "$src" "$dest"
    echo "✅ Linked $dest → $src"
}

# Link home directory dotfiles
echo "🔗 Linking home files..."
for file in "$DOTFILES_DIR/home"/.*; do
    [ "$(basename "$file")" = "." ] && continue
    [ "$(basename "$file")" = ".." ] && continue
    link_file "$file" "$HOME/$(basename "$file")"
done

# Link ~/.config files
echo "🔗 Linking config files..."
for dir in "$DOTFILES_DIR/config"/*; do
    link_file "$dir" "$CONFIG_DIR/$(basename "$dir")"
done

# Link bin scripts to ~/bin
if [ -d "$DOTFILES_DIR/bin" ]; then
    mkdir -p "$HOME/bin"
    echo "🔗 Linking bin scripts..."
    for script in "$DOTFILES_DIR/bin"/*; do
        link_file "$script" "$HOME/bin/$(basename "$script")"
    done
fi

# Function to install vim-plug
install_vim_plug() {
    local plug_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

    if command -v nvim >/dev/null 2>&1; then
        echo "📥 Installing vim-plug for Neovim..."
        curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs "$plug_url"
        echo "📦 Installing Neovim plugins..."
        nvim +PlugInstall +qall
    fi

    if command -v vim >/dev/null 2>&1; then
        echo "📥 Installing vim-plug for Vim..."
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs "$plug_url"
        echo "📦 Installing Vim plugins..."
        vim +PlugInstall +qall
    fi
}

# Install vim-plug & plugins if config present
if [ -f "$HOME/.vimrc" ] || [ -d "$CONFIG_DIR/nvim" ]; then
    install_vim_plug
fi

echo "🎉 Dotfiles installation complete!"

