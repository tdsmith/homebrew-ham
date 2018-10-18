class Chirp < Formula
  include Language::Python::Virtualenv

  desc "Programs amateur radios"
  homepage "http://chirp.danplanet.com/projects/chirp/wiki/Home"
  url "https://trac.chirp.danplanet.com/chirp_daily/daily-20181014/chirp-daily-20181014.tar.gz"
  sha256 "3f7d8f5dea18c018b2158bc4eee733f82a4db6b64bbb555cab718ac55ffa7b85"

  depends_on "gtk-mac-integration"
  depends_on "libxml2" => "with-python"
  depends_on "py2cairo"
  depends_on "pygtk"
  depends_on "python@2"

  resource "pyserial" do
    url "https://files.pythonhosted.org/packages/1f/3b/ee6f354bcb1e28a7cd735be98f39ecf80554948284b41e9f7965951befa6/pyserial-3.2.1.tar.gz"
    sha256 "1eecfe4022240f2eab5af8d414f0504e072ee68377ba63d3b6fe6e66c26f66d1"
  end


  def install
    inreplace "setup.py", "darwin", "noop"
    inreplace "chirp/ui/mainapp.py", "reporting.check_for_updates(updates_callback)", "pass"

    # Fix a crash on launch
    # https://github.com/tdsmith/homebrew-ham/issues/10
    inreplace "chirp/ui/mainapp.py", "macapp.set_dock_icon_pixbuf(icon_pixmap)", "pass"

    virtualenv_install_with_resources
    ln_s bin/"chirpw", bin/"chirp"
  end
end
