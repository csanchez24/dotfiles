# dotfiles
Dev environment dot( . ) files
Install NeoVim
Install kitty => brew install kitty
Install wezterm=> 				brew tap wez/wezterm 				brew install --cask wez/wezterm/wezterm


Install Neovim

Brew install neovim

Install Prezto

 https://github.com/sorin-ionescu/prezto

FONTS
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-hack-nerd-font


Install starship

brew install starship
~/.config/starship.toml


Install cargo
curl https://sh.rustup.rs -sSf | sh
install stylus

https://github.com/JohnnyMorganz/StyLua

cargo install stylua

Link all the files

ln -s /Users/carlosjosesanchezespinosa/Code/Terminal/dotfiles/nvim /Users/carlosjosesanchezespinosa/.config/nvim

ln -s /Users/carlosjosesanchezespinosa/Code/Terminal/dotfiles/kitty /Users/carlosjosesanchezespinosa/.config/kitty

ln -s /Users/carlosjosesanchezespinosa/Code/Terminal/dotfiles/wezterm /Users/carlosjosesanchezespinosa/.config/wezterm

ln -s /Users/carlosjosesanchezespinosa/Code/Terminal/dotfiles/lf /Users/carlosjosesanchezespinosa/.config/lf

ln -s /Users/carlosjosesanchezespinosa/Code/Terminal/dotfiles/starship.toml /Users/carlosjosesanchezespinosa/.config/starship.toml

ln -s /Users/carlosjosesanchezespinosa/Code/Terminal/dotfiles/.zshrc /Users/carlosjosesanchezespinosa/.zshrc

ln -s /Users/carlosjosesanchezespinosa/Code/Terminal/dotfiles/.zshenv /Users/carlosjosesanchezespinosa/.zshenv

ln -s /Users/carlosjosesanchezespinosa/Code/Terminal/dotfiles/.zprofile /Users/carlosjosesanchezespinosa/.zprofile

ln -s /Users/carlosjosesanchezespinosa/Code/Terminal/dotfiles/.zpreztorc /Users/carlosjosesanchezespinosa/.zpreztorc

Install italic font

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

Install dependen 

brew install lf brew install lazygit
brew install bat
brew install fzf
brew install ripgrep
brew install fd
brew install pyenv
brew install go
brew install wget

Open nvim say Y to packer
Packerinstall
Packercompile
Packerupdate

install LSP
Lspinstall languaje

Install the threeseetier
TSinstall language


Install globally

npm install -g eslint  
npm install -g prettier


Find Package for NeoVim

https://neovimcraft.com/
https://github.com/rockerBOO/awesome-neovim
