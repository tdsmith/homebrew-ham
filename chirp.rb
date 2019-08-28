class Chirp < Formula
  include Language::Python::Virtualenv

  desc "Programs amateur radios"
  homepage "http://chirp.danplanet.com/projects/chirp/wiki/Home"
  url "https://trac.chirp.danplanet.com/chirp_daily/daily-20190718/chirp-daily-20190718.tar.gz"
  sha256 "c5e7bc9904387382c4da63b583d947391bcc615536fe86f6c5a8d28c316ecffe"

  depends_on "gtk-mac-integration"
  depends_on "py2cairo"
  depends_on "pygtk"
  depends_on "python@2"

  resource "pyserial" do
    url "https://files.pythonhosted.org/packages/1f/3b/ee6f354bcb1e28a7cd735be98f39ecf80554948284b41e9f7965951befa6/pyserial-3.2.1.tar.gz"
    sha256 "1eecfe4022240f2eab5af8d414f0504e072ee68377ba63d3b6fe6e66c26f66d1"
  end

  resource "libxml2" do
    url "http://xmlsoft.org/sources/libxml2-2.9.9.tar.gz"
    sha256 "94fb70890143e3c6549f265cee93ec064c80a84c42ad0f23e85ee1fd6540a871"
  end


  def install
    inreplace "setup.py", "darwin", "noop"
    inreplace "chirp/ui/mainapp.py", "reporting.check_for_updates(updates_callback)", "pass"

    # Fix a crash on launch
    # https://github.com/tdsmith/homebrew-ham/issues/10
    inreplace "chirp/ui/mainapp.py", "macapp.set_dock_icon_pixbuf(icon_pixmap)", "pass"

    venv = virtualenv_create(libexec)

    resource("libxml2").stage do
      system "./configure", "--disable-dependency-tracking",
                            "--prefix=#{libexec}",
                            "--without-python",
                            "--without-lzma"
      system "make", "install"

      cd "python" do
        # We need to insert our include dir first
        inreplace "setup.py", "includes_dir = [",
                              "includes_dir = ['#{libexec}/include', '#{MacOS.sdk_path}/usr/include',"
        system libexec/"bin/python", "setup.py", "install", "--prefix=#{libexec}"
      end
    end

    venv.pip_install resource("pyserial")
    venv.pip_install_and_link buildpath
    ln_s bin/"chirpw", bin/"chirp"
  end
end
