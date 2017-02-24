class Direwolf < Formula
  desc "Software modem and TNC for AX.25"
  homepage "https://github.com/wb2osz/direwolf"
  url "https://github.com/wb2osz/direwolf/archive/1.4-dev-E.tar.gz"
  sha256 "1e0d75fd7485040ced350fa95714f3760925f039fcd68b45e1d2153a7101f9da"
  version "1.4a5"

  depends_on "hamlib"
  depends_on "portaudio"

  def install
    inreplace "Makefile.macosx", "LDLIBS += -framework CoreAudio",
                                 "LDLIBS += $(EXTRA_LDLIBS) -framework CoreAudio"
    inreplace ["decode_aprs.c", "symbols.c"], "/usr/local", opt_prefix
    system "make -k all EXTRA_CFLAGS=-DUSE_HAMLIB EXTRA_LDLIBS=-lhamlib || true"
    bin.install %w[direwolf aclients decode_aprs gen_fff gen_packets
      ll2utm log2gpx text2tt tt2text ttcalc utm2ll]
    pkgshare.install "tocalls.txt", "symbols-new.txt"
    man.install "man1"
    doc.install Dir["doc/*"]
  end
end
