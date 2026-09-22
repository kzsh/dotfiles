# Installing kanshi with `kanshictl` on Debian

Debian's `kanshi` package is built without IPC, so it ships no `kanshictl`.
Build kanshi from source with IPC enabled instead.

## 1. Remove the packaged kanshi

```sh
sudo apt remove kanshi
```

Otherwise `/usr/bin/kanshi` and `/usr/local/bin/kanshi` both exist and it's a
coin flip which one sway starts.

## 2. Build dependencies

```sh
sudo apt install build-essential git meson ninja-build pkg-config \
  libwayland-dev libjson-c-dev scdoc
```

- `libjson-c-dev` is needed by vali, the varlink library behind `kanshictl`.
- `scdoc` builds the man pages. Optional; without it meson reports
  `Man pages: NO`.

vali and libscfg are not packaged in Debian. meson fetches them as
subprojects in the next step. libvarlink is **not** needed; kanshi uses vali.

## 3. Build and install

```sh
git clone https://gitlab.freedesktop.org/emersion/kanshi
cd kanshi
meson setup build --prefix=/usr/local -Dipc=enabled --wrap-mode=default
ninja -C build
sudo ninja -C build install
sudo ldconfig
```

- `sudo ldconfig` registers the vali library installed under `/usr/local`.
  Without it `kanshictl` fails with
  `libvali.so.1: cannot open shared object file`.
- `-Dipc=enabled` makes configuration fail loudly if IPC can't be built,
  instead of silently producing a kanshi without `kanshictl`.
- `--wrap-mode=default` lets meson download subprojects. Debian's meson
  disables this by default, which fails with
  `Automatic wrap-based subproject downloading is disabled`.

The configure summary should show `IPC : YES`. Add `--wipe` to
`meson setup` when re-running it over an existing `build/`.

## 4. Link the config

Link the whole directory: `config` includes `profiles.generated`, which
`generate` writes next to itself.

```sh
ln -s ~/src/remote/dotfiles/linux/config/kanshi ~/.config/kanshi
~/.config/kanshi/generate
```

## 5. Verify

Reload sway (the sway config restarts kanshi on every reload), then:

```sh
command -v kanshi kanshictl   # both should be in /usr/local/bin
kanshictl reload
```

If `kanshictl` can't connect, an old kanshi is still running:
`pkill -x kanshi` and reload sway.

## Changing profiles

Don't edit `profiles.generated` (gitignored). Edit the inputs instead:

- `monitors`: each monitor's alias, logical size and description, the
  fallback screen, and the profile applied on hotplug.
- `profiles/<name>`: one layout per file, one line per monitor, placed
  relative to another monitor with `|` alternatives for when that one is
  unplugged. The grammar is documented at the top of `generate`.

Then run `~/.config/kanshi/generate && kanshictl reload`, or reload sway,
which does both. `generate` refuses to write a layout where some combination
of connected monitors would leave a screen unreachable or overlapping.

## Updating

```sh
cd kanshi
git pull
ninja -C build
sudo ninja -C build install
sudo ldconfig
```

## Uninstalling

```sh
sudo ninja -C build uninstall
```
