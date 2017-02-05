class Chirp < Formula
  include Language::Python::Virtualenv

  desc "Programs amateur radios"
  homepage "http://chirp.danplanet.com/projects/chirp/wiki/Home"
  url "http://trac.chirp.danplanet.com/chirp_daily/daily-20170126/chirp-daily-20170126.tar.gz"
  sha256 "622e1b454d2c85017afcadef4215cd58dea007ae040991283e350f1a3b21e97c"

  depends_on "gtk-mac-integration"
  depends_on "libxml2" => "with-python"
  depends_on "py2cairo"
  depends_on "pygtk"
  depends_on :python

  # Fix resource loading
  # http://chirp.danplanet.com/issues/4487
  patch do
    url "http://intrepid.danplanet.com/pipermail/chirp_devel/attachments/20170204/2a8b6961/attachment.obj"
    sha256 "f50cce16ed8e75496e93e99fc04b47d4cd995f9986815d7b441b2f0dc8e68f87"
  end

  # Fix gtk-mac-integration import
  # http://chirp.danplanet.com/issues/4489
  patch do
    url "https://gist.githubusercontent.com/tdsmith/5b40340538a69a09e27547662aee4337/raw/c307052e619b00475a58a07370cd3cd1f4182b47/gtkmacintegration.patch"
    sha256 "0d205089c400823fa4f35f35c1117a715eb2a4e82caff2fe345cd2480e99d1b4"
  end

  # Set dock icon
  # http://chirp.danplanet.com/issues/4491
  patch :DATA

  resource "pyserial" do
    url "https://files.pythonhosted.org/packages/1f/3b/ee6f354bcb1e28a7cd735be98f39ecf80554948284b41e9f7965951befa6/pyserial-3.2.1.tar.gz"
    sha256 "1eecfe4022240f2eab5af8d414f0504e072ee68377ba63d3b6fe6e66c26f66d1"
  end


  def install
    inreplace "setup.py", "darwin", "noop"
    virtualenv_install_with_resources
    ln_s bin/"chirpw", bin/"chirp"
  end
end
__END__
diff --git a/chirp/ui/mainapp.py b/chirp/ui/mainapp.py
index bea93ef..011c6cf 100644
--- a/chirp/ui/mainapp.py
+++ b/chirp/ui/mainapp.py
@@ -1947,6 +1947,13 @@ of file.
             LOG.error("No MacOS support: %s" % e)
             return

+        this_platform = platform.get_platform()
+        icon = (this_platform.find_resource("chirp.png") or
+                this_platform.find_resource(os.path.join("pixmaps", "chirp.png")))
+        if os.path.exists(icon):
+            icon_pixmap = gtk.gdk.pixbuf_new_from_file(icon)
+            macapp.set_dock_icon_pixbuf(icon_pixmap)
+
         menu_bar.hide()
         macapp.set_menu_bar(menu_bar)
