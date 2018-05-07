class Xastir < Formula
  desc "X amateur station tracking and information reporting"
  homepage "http://www.xastir.org/"
  url "https://downloads.sourceforge.net/xastir/xastir-2.0.8.tar.gz"
  sha256 "775db0e3c4355051a9030b8398a1d995d48b3b721fa1c9bce5e3010300c1ebb6"

  depends_on "proj"
  depends_on "pcre"
  depends_on "berkeley-db"
  depends_on "gdal"
  depends_on "libgeotiff"
  depends_on "openmotif"
  depends_on "jasper"
  depends_on "graphicsmagick"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/xastir", "-q"
  end
end
