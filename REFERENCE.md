# archsweep

A tiny, **dependency-free** TUI to clean common junk on Arch-based systems
(Arch, CachyOS, EndeavourOS, Manjaro, …).

Pure Bash — no `fzf`, `gum`, `dialog` or `whiptail`. It only needs `pacman` and
coreutils, which every Arch box already has.

## What it cleans

| Task | Command under the hood | Needs root |
|------|------------------------|:----------:|
| Remove orphan packages | `pacman -Qdtq \| pacman -Rns -` | yes |
| Trim pacman cache (keep last N) | `paccache -rk<N>` | yes |
| Drop cache of uninstalled packages | `paccache -ruk0` | yes |
| Clean AUR helper cache | `paru -Sc` / `yay -Sc` | no |
| Vacuum systemd journal | `journalctl --vacuum-time=<T>` | yes |

Everything is **opt-in**: nothing runs until you select it and confirm. The
cache tasks keep the most recent versions by default, so package rollback still
works.

## Requirements

- An Arch-based distro (Arch, CachyOS, EndeavourOS, Manjaro, …) — anything with `pacman`.
- `bash` and coreutils (already present on every Arch system).
- Optional: `pacman-contrib` for the two pacman-cache tasks (`paccache`). If it
  is missing those tasks are skipped and everything else still works:
  ```bash
  sudo pacman -S --needed pacman-contrib
  ```

## Installation

### Option 1 — clone and run

```bash
git clone https://github.com/talhacaglar/archsweep.git
cd archsweep
chmod +x archsweep      # only needed if the executable bit was lost
./archsweep
```

### Option 2 — install on your `PATH` (run it from anywhere)

```bash
git clone https://github.com/talhacaglar/archsweep.git
install -Dm755 archsweep/archsweep ~/.local/bin/archsweep
archsweep                # make sure ~/.local/bin is on your $PATH
```

If `~/.local/bin` is not on your `PATH`, add this to `~/.bashrc` (or
`~/.config/fish/config.fish` for fish):

```bash
export PATH="$HOME/.local/bin:$PATH"
```

### Option 3 — one-liner (download just the script)

```bash
curl -fsSL https://raw.githubusercontent.com/talhacaglar/archsweep/main/archsweep \
  -o ~/.local/bin/archsweep && chmod +x ~/.local/bin/archsweep
```

## Usage

Run it and you get an interactive picker — move with the arrow keys, toggle
tasks with `space`, then press `enter`. Nothing is deleted until you confirm.

```bash
archsweep        # or ./archsweep if not installed on PATH
```

### Keys

| Key | Action |
|-----|--------|
| `↑` / `↓` or `k` / `j` | move |
| `space` | toggle the highlighted task |
| `a` | select / deselect all |
| `enter` | run the selected tasks |
| `q` / `esc` | quit |

## Configuration

Override the defaults with environment variables:

```bash
# keep only the current version of each package in the cache
ARCHSWEEP_KEEP_VERSIONS=1 ./archsweep

# keep one month of journal logs
ARCHSWEEP_JOURNAL_KEEP=1month ./archsweep
```

| Variable | Default | Meaning |
|----------|---------|---------|
| `ARCHSWEEP_KEEP_VERSIONS` | `2` | pacman cache versions kept per package |
| `ARCHSWEEP_JOURNAL_KEEP` | `2weeks` | journal retention (`man journalctl`, `--vacuum-time`) |

## Notes

- `paccache` comes from the `pacman-contrib` package. If it is missing, the two
  cache tasks simply report that and are skipped — the rest still works.
- The AUR task auto-detects `paru` or `yay` and is intentionally run **without**
  root, because AUR helpers refuse to run as root.
- It refuses to start on non-`pacman` systems.

## License

MIT — see [LICENSE](LICENSE).
