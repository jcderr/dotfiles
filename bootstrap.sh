#!/usr/bin/env zsh
set -euo pipefail

info()  { print -P "%F{cyan}[INFO]%f  $1" }
warn()  { print -P "%F{yellow}[WARN]%f  $1" }
die()   { print -P "%F{red}[ERROR]%f $1" >&2; exit 1 }
ok()    { print -P "%F{green}[OK]%f    $1" }

# ── Homebrew ──────────────────────────────────────────────────────────────────

if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  ok "Homebrew already installed"
fi

info "Installing Homebrew packages..."
brew install \
  colima \
  docker \
  docker-compose \
  ffmpeg \
  gh \
  git \
  htop \
  powerline-shell \
  python@3.13 \
  tmux \
  vim \
  virtualenv \
  watch

# ── oh-my-zsh ─────────────────────────────────────────────────────────────────

if [[ -d "$HOME/.oh-my-zsh" ]]; then
  ok "oh-my-zsh already installed"
else
  info "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ── Dotfiles symlinks ─────────────────────────────────────────────────────────

DOTFILES="$HOME/.dotfiles"

if [[ ! -d "$DOTFILES" ]]; then
  info "Cloning dotfiles..."
  git clone --recursive https://github.com/jcderr/dotfiles.git "$DOTFILES"
else
  ok "Dotfiles already cloned at $DOTFILES"
fi

symlink() {
  local src="$DOTFILES/$1"
  local dst="$HOME/$2"
  if [[ -L "$dst" ]]; then
    ok "$dst already symlinked"
  elif [[ -e "$dst" ]]; then
    warn "$dst exists but is not a symlink — backing up to ${dst}.bak"
    mv "$dst" "${dst}.bak"
    ln -s "$src" "$dst" && ok "Linked $dst -> $src"
  else
    ln -s "$src" "$dst" && ok "Linked $dst -> $src"
  fi
}

# oh-my-zsh is installed directly to ~/.oh-my-zsh by its own installer
symlink zshrc   .zshrc
symlink vimrc   .vimrc
symlink tmux.conf .tmux.conf
symlink gitconfig .gitconfig

# ── vim-plug ──────────────────────────────────────────────────────────────────

if [[ -f "$HOME/.vim/autoload/plug.vim" ]]; then
  ok "vim-plug already installed"
else
  info "Installing vim-plug..."
  curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  info "Run :PlugInstall inside vim to install plugins"
fi

# ── iTerm2 shell integration ──────────────────────────────────────────────────

if [[ -f "$HOME/.iterm2_shell_integration.zsh" ]]; then
  ok "iTerm2 shell integration already installed"
else
  info "Installing iTerm2 shell integration..."
  curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash
fi

ok "Bootstrap complete. Start a new shell to pick up the changes."
