# homebrew-ham

### [Homebrew](https://brew.sh/) formulae for ham radio software.

If you don't have Homebrew installed, make sure to [visit their website](https://brew.sh) to install it first. It's a free trusted open source package manager for macOS that makes finding, installing, and updating software packages (such as CHIRP) incredibly easy. It can be installed with a single command.

---

## CHIRP

### Programs amateur radios

[Homepage](http://chirp.danplanet.com/projects/chirp/wiki/Home)

To install CHIRP via the command line:
* `brew install tdsmith/ham/chirp`

To run CHRIP via the command line:
* `chirp`

To uninstall CHIRP via the command line:
* `brew uninstall chirp`

---

## Dire Wolf

### Software modem and TNC for AX.25

[Homepage](https://github.com/wb2osz/direwolf)

To install Dire Wolf via the command line:
* `brew install tdsmith/ham/direwolf`

To uninstall Dire Wolf via the command line:
* `brew uninstall direwolf`

---

## Xastir

### X amateur station tracking and information reporting

[Homepage](http://www.xastir.org/)

To install Xastir via the command line:
* `brew install tdsmith/ham/xastir`

To uninstall Xastir via the command line:
* `brew uninstall xastir`

---

To update everything from Homebrew via the command line, run these three commands:
* `brew update` (checks for new versions)
* `brew upgrade` (downloads and installs new versions)
* `brew cleanup` (deletes old versions once the new ones are installed)

If you've uninstalled everything from tdsmith/ham, you can remove the tap via the command line:
* `brew untap tdsmith/ham`