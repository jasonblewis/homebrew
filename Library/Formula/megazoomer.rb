require 'formula'

class Megazoomer < Formula
  url 'http://ianhenderson.org/download/megazoomer.zip'
  homepage 'http://ianhenderson.org/megazoomer.html'
  md5 '60d7be27eaf5fcd72c9a3e18cd86360d'
  version '0.5'

  # depends_on 'cmake'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    # system "cmake . #{std_cmake_parameters}"
    system "make install"
  end

  def test
    # This test will fail and we won't accept that! It's enough to just
    # replace "false" with the main program this formula installs, but
    # it'd be nice if you were more thorough. Test the test with
    # `brew test megazoomer`. Remove this comment before submitting
    # your pull request!
    system "false"
  end
end
