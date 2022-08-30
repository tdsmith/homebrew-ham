class Xastir < Formula
  desc "X amateur station tracking and information reporting"
  homepage "http://www.xastir.org/"
  url "https://github.com/Xastir/Xastir/archive/refs/tags/Release-2.1.8.tar.gz"
  sha256 "aa88069f149dbe720276d0134282bc491e7993d8a88380c8fe2a4735ee6444fc"
  head "https://github.com/Xastir/Xastir.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  depends_on "imagemagick@6"
  depends_on "libgeotiff"
  depends_on "openmotif"
  depends_on "proj"
  depends_on "shapelib"

  def install
    system "./bootstrap.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "-j4"
    system "make", "install"
  end

  test do
    system "#{bin}/xastir", "-q"
  end
end
