#!/usr/bin/env bash
set -euo pipefail
repo_dir="$(cd "$(dirname "$0")/.." && pwd)"
# All cleanup/system commands are mock functions inherited by the child shell.
pacman() { return 1; }
paccache() {
  case "$1" in
    -d*) echo 'disk space saved: 1 MiB';;
    *) return "${MOCK_FAILURE:-0}";;
  esac
}
sudo() { if [[ "$1" == -v ]]; then return 0; fi; "$@"; }
paru() { :; }
yay() { :; }
journalctl() { if [[ "$1" == --disk-usage ]]; then echo 'take up 1 MiB'; fi; }
df() { printf 'Avail\n100M\n'; }
export -f pacman paccache sudo paru yay journalctl df
if output=$(MOCK_FAILURE=1 bash "$repo_dir/archsweep" <<< $'\ny'); then
  echo 'Failed cleanup incorrectly succeeded' >&2
  exit 1
fi
[[ "$output" == *'Completed with 2 failed task(s).'* ]]
[[ "$output" != *'All done.'* ]]
output=$(MOCK_FAILURE=0 bash "$repo_dir/archsweep" <<< $'\ny')
[[ "$output" == *'All done.'* ]]
echo 'cleanup success/failure exit and summaries: PASS'
