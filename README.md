
# Terminal and Neovim set up

follow the steps to have the terminal and neovim.




## Installation Terminal

Install Wezterm, Prezto, Starship

Wezterm
```bash
  brew tap wez/wezterm
  brew install --cask wez/wezterm/wezterm
  or
  follow the steps https://github.com/wez/wezterm
```
Prezto
```bash
   https://github.com/sorin-ionescu/prezto
```
Fonts
```bash
  brew tap homebrew/cask-fonts
  brew install --cask font-jetbrains-mono-nerd-font
  brew install --cask font-hack-nerd-font
```
Starship
```bash
  brew install starship
```
Cargo and Stylus
```bash
  curl https://sh.rustup.rs -sSf | sh
  cargo install stylua
```
Install italic Font
```bash
  Create a file xterm-256color-italic.terminfo
  # A xterm-256color based TERMINFO that adds the escape sequences for italic.
  # Install:
  #   tic -x xterm-256color-italic.terminfo
  # Usage:
  #   export TERM=xterm-256color-italic
  # A xterm-256color based TERMINFO that adds the escape sequences for italic.
  xterm-256color-italic|xterm with 256 colors and italic,
	sitm=\E[3m, ritm=\E[23m,
	use=xterm-256color,

  Run 
    tic -x xterm-256color-italic.terminfo 
  and delete file
```
Install others dependencies
```bash
  brew install lf
  brew install lazygit
  brew install bat
  brew install fzf
  brew install ripgrep
  brew install fd
  brew install pyenv
  brew install go
  brew install wget
```

Install eslint and prettier Globally
```bash
  npm install -g eslint  
  npm install -g prettier
```

Clone Repo and Link files

after clone the repo links the files
```bash
  ln -s ~/Code/Terminal/dotfiles/nvim ~/.config/nvim
  
  ln -s ~/Code/Terminal/dotfiles/wezterm ~/.config/wezterm

  ln -s ~/Code/Terminal/dotfiles/lf ~/.config/lf
  
  ln -s ~/Code/Terminal/dotfiles/starship.toml ~/.config/starship.toml

  ln -s ~/Code/Terminal/dotfiles/.zshrc ~/.zshrc

  ln -s ~/Code/Terminal/dotfiles/.zshenv ~/.zshenv

  ln -s ~/Code/Terminal/dotfiles/.zprofile ~/.zprofile

  ln -s ~/Code/Terminal/dotfiles/.zpreztorc ~/.zpreztorc
```

Open neovim and install run Packerinstall and Packercompile

### Ready to use