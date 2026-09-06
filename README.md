# archsweep

[English](#english) · [Türkçe](#türkçe)

## English

An opt-in Bash terminal cleaner for Arch-based Linux systems. Select maintenance tasks, review them, and confirm before anything is removed.

### Features

- Orphan packages, pacman caches, AUR helper caches and systemd journal cleanup.
- No `fzf`, `gum` or `dialog`; built around Bash and system utilities.
- Configurable cache retention and journal age.

### Getting started

Requires a system with `pacman`. Install `pacman-contrib` if you want the `paccache` tasks; otherwise those tasks are skipped.

```bash
git clone https://github.com/talhacaglar/archsweep.git
cd archsweep
./archsweep
```

Use arrows or `j`/`k` to move, Space to toggle, `a` to select all, Enter to run and `q`/Escape to quit. Defaults: `ARCHSWEEP_KEEP_VERSIONS=2`, `ARCHSWEEP_JOURNAL_KEEP=2weeks`. AUR helpers run without root; privileged cleanup requests sudo when required.

[Detailed technical reference](REFERENCE.md)

## Türkçe

Arch tabanlı Linux sistemleri için seçime dayalı Bash terminal temizleyicisi. Bakım görevlerini seçin, gözden geçirin ve silme işleminden önce onaylayın.

### Özellikler

- Yetim paket, pacman önbelleği, AUR yardımcısı önbelleği ve systemd günlük temizliği.
- `fzf`, `gum` veya `dialog` gerekmez; Bash ve sistem araçlarıyla çalışır.
- Ayarlanabilir önbellek sürüm sayısı ve günlük saklama süresi.

### Başlangıç

`pacman` bulunan bir sistem gerekir. `paccache` görevleri için `pacman-contrib` kurun; yoksa bu görevler atlanır.

```bash
git clone https://github.com/talhacaglar/archsweep.git
cd archsweep
./archsweep
```

Oklar veya `j`/`k` ile gezin; Boşluk ile seçin, `a` ile tümünü seçin, Enter ile çalıştırın, `q`/Escape ile çıkın. Varsayılanlar: `ARCHSWEEP_KEEP_VERSIONS=2`, `ARCHSWEEP_JOURNAL_KEEP=2weeks`. AUR yardımcıları root olmadan çalışır; yetki gereken temizlik adımları sudo ister.

[Ayrıntılı teknik referans](REFERENCE.md)
