# dotfiles

dotfiles/
├── README.md               # Overview & setup instructions
├── install.sh              # Bootstrap script to symlink files
├── .gitignore              # Ignore temp files / secrets
│
├── home/                   # Files that go directly in $HOME
│   ├── .bashrc
│   ├── .zshrc
│   ├── .vimrc
│   ├── .gitconfig
│   └── .tmux.conf
│
├── config/                 # For ~/.config files (XDG-compliant apps)
│   ├── nvim/
│   │   ├── init.lua
│   │   └── lua/
│   ├── alacritty/
│   │   └── alacritty.yml
│   └── starship.toml
│
├── bin/                    # Custom scripts to add to $PATH
│   ├── backup.sh
│   └── cleanup_logs.sh
│
├── local/                  # Machine-specific overrides (gitignored)
│   ├── .gitconfig.local
│   └── .zshrc.local
│
└── themes/                 # Color schemes / fonts
    ├── alacritty.yml
    ├── vim-colors.vim
    └── terminal.itermcolors

