class Chirp < Formula
  include Language::Python::Virtualenv

  desc "Programs amateur radios"
  homepage "http://chirp.danplanet.com/projects/chirp/wiki/Home"
  url "http://trac.chirp.danplanet.com/chirp_daily/daily-20170126/chirp-daily-20170126.tar.gz"
  sha256 "622e1b454d2c85017afcadef4215cd58dea007ae040991283e350f1a3b21e97c"

  depends_on "libxml2" => "with-python"
  depends_on "py2cairo"
  depends_on "pygtk"
  depends_on :python

  resource "pyserial" do
    url "https://files.pythonhosted.org/packages/1f/3b/ee6f354bcb1e28a7cd735be98f39ecf80554948284b41e9f7965951befa6/pyserial-3.2.1.tar.gz"
    sha256 "1eecfe4022240f2eab5af8d414f0504e072ee68377ba63d3b6fe6e66c26f66d1"
  end

  def install
    inreplace "setup.py", "darwin", "noop"
    virtualenv_install_with_resources
    mv bin/"chirpw", bin/"chirp"
  end
end
