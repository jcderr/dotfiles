# dotfiles — CLAUDE.md

## What this repo is

Personal shell environment for a single macOS user (Jeremy). Deployed via symlinks from `~/.dotfiles/` to the home directory. Not a multi-user or enterprise setup — correctness on one machine matters more than portability to arbitrary systems.

## Deployment model

All files are symlinked into `~`. `bootstrap.sh` sets this up on a new machine.

| Repo file | Live location |
|-----------|--------------|
| `zshrc` | `~/.zshrc` |
| `vimrc` | `~/.vimrc` |
| `tmux.conf` | `~/.tmux.conf` |
| `gitconfig` | `~/.gitconfig` |
| `aliases` | sourced by `zshrc` |
| `func` | sourced by `zshrc` |

Per-machine overrides go in `~/.zshrc.local`, which `zshrc` sources automatically. Never use branches for machine-specific config.

External tools (oh-my-zsh, powerline-shell, vim-plug, Homebrew packages) are installed by `bootstrap.sh` — they are not tracked in this repo.

## Adding or changing things

**Shell functions** go in `func`. **Aliases** go in `aliases`. If a domain grows to 5+ related functions, split it into `func.d/<domain>.zsh` and have `func` source that directory.

**Vim plugins** are managed by vim-plug. Add a `Plug` line to `vimrc` and run `:PlugInstall`. Remove a line and run `:PlugClean`.

**New Homebrew dependencies** belong in the `brew install` block in `bootstrap.sh`.

**No submodules.** All third-party tools are installed independently. If you're tempted to add a submodule, add a `brew install` or installer command to `bootstrap.sh` instead.

## Maintenance principles

1. **Delete over preserve.** Commented-out code, stale functions, references to tools no longer in use — remove them. Don't keep things "just in case."
2. **No hardcoded paths.** No `/Users/<anyone>/`, no `/usr/local/bin/<tool>` — use `command -v`, `which`, or PATH resolution.
3. **Guard optional sources.** Any `source` or `.` call for a file that might not exist should be guarded: `[[ -e "$file" ]] && source "$file"`.
4. **Keep bootstrap current.** After installing a new tool you rely on, add it to `bootstrap.sh` so a fresh machine gets it too.
5. **No speculative additions.** Don't add a function for a workflow you don't have yet. Add it when you need it.
