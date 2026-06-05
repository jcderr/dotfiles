# dotfiles — CLAUDE.md

## What this repo is

Personal shell environment for a single macOS user (Jeremy). Deployed via symlinks from `~/.dotfiles/` to the home directory. Not a multi-user or enterprise setup — correctness on one machine matters more than portability to arbitrary systems.

## Goal state

A lean, symlink-deployed dotfiles repo with:
- No vendored third-party repos (no git submodules)
- All external dependencies installed via Homebrew or their own standard installers, not tracked here
- A single `bootstrap.sh` that can set up a new machine from scratch
- Shell functions and aliases organized by domain, easy to audit and prune
- No dead code — if a function targets a tool or workflow no longer in use, it gets deleted

## Current deployment model

Files in this repo are symlinked into `~`:

| Repo file | Symlink target |
|-----------|---------------|
| `zshrc` | `~/.zshrc` |
| `vimrc` | `~/.vimrc` |
| `tmux.conf` | `~/.tmux.conf` |
| `aliases` | sourced by `~/.zshrc` via `~/.dotfiles/aliases` |
| `func` | sourced by `~/.zshrc` via `~/.dotfiles/func` |

`~/.gitconfig` is currently a standalone file (not symlinked). Goal: add it to the repo and symlink it.

## Priorities when making changes

1. **Delete over preserve.** If something is commented out, stale, or references a tool no longer in use, remove it. Don't leave dead code "just in case."
2. **No submodules.** The current submodules (oh-my-zsh, powerline-shell, powerline-fonts, solarized, vundle, vim-jekyll, tmux-scroll-copy-mode) should all be replaced with Homebrew installs or standard installers, then removed from the repo.
3. **Functions belong in `func`, aliases in `aliases`.** If a new domain grows large enough (e.g., 5+ related functions), split it into `func.d/<domain>.zsh` and have `func` source that directory.
4. **No hardcoded paths to other people's home directories.** (`/Users/sbrown/` appears in `vimrc` — remove it.)
5. **Keep `bootstrap.sh` current.** It should reflect the actual install steps needed on a fresh Mac today.

## Known technical debt (priority order)

### High — causes real problems
- `zshrc`: powerline setup functions are defined twice (live + commented-out duplicate); remove the commented block
- `zshrc`: `eval "$(pip3 completion --zsh)"` is slow and breaks if pip3 is absent; replace with a static completion snippet or remove
- `zshrc`: `. "$HOME/.local/bin/env"` hard-fails if the file doesn't exist; guard it
- `func`: `flush_dns()` uses `discoveryutil` which was removed in macOS El Capitan (2015); replace with `dscacheutil -flushcache && sudo killall -HUP mDNSResponder`

### Medium — stale but not breaking
- `func`: `kubeexec()`, `scale()`, `kbounce()`, `kpod()`, `klog()` target CoreOS-era Kubernetes (RC objects, `docker exec` via SSH to a `core` user); modernize or delete
- `gitconfig`: SourceTree mergetool path points to a Homebrew-cask location from ~2015 that no longer exists
- `vimrc`: Uses Vundle (`Bundle` declarations); Vundle is effectively unmaintained; consider migrating to vim-plug or native vim packages
- `vimrc`: `WordProcessorMode()` has a hardcoded thesaurus path to `/Users/sbrown/.vim/` — fix or remove
- `aliases`: Nearly empty (3 commented-out lines); either populate or remove the file

### Low — cosmetic / organizational
- `tmux/` subdirectory contains a second, older tmux config using deprecated syntax (not the one in use); delete it
- `README` is an openssl reference note, not a README; delete or move content somewhere appropriate
- `tmux.conf`: Several commented-out color settings using old tmux syntax; clean up
- `Dockerfile`: Minimal, exploratory; unclear purpose; delete unless there's a reason to keep it

## Submodule removal plan

Each submodule should be removed from `.gitmodules` and the repo once its replacement is confirmed installed:

| Submodule | Replacement |
|-----------|-------------|
| `oh-my-zsh` | `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"` |
| `powerline-fonts` | `brew install --cask font-meslo-lg-nerd-font` (or whichever font is actually in use) |
| `powerline-shell` | `pip install powerline-shell` |
| `solarized` | iTerm2/Terminal color presets installed directly; tmux solarized line removed from tmux.conf |
| `vim/bundle/vundle` | Switch vimrc to vim-plug: `curl -fLo ~/.vim/autoload/plug.vim --create-dirs ...` |
| `vim/bundle/vim-jekyll` | Add to vim-plug block if still needed |
| `tmux-scroll-copy-mode` | Built-in tmux mouse/scroll behavior covers this in modern tmux |

## What NOT to do

- Don't add features speculatively. If a function solves a problem that no longer exists, delete it rather than "modernizing" it.
- Don't add comments explaining what code does — function names should be self-explanatory. Only add a comment if there's a non-obvious constraint or workaround.
- Don't create machine-specific branches. Use `~/.zshrc.local` (already sourced) for per-machine overrides.
