require 'formula'

class Libvisual < Formula
  url 'http://sourceforge.net/projects/libvisual/files/libvisual/libvisual-0.4.0/libvisual-0.4.0.tar.gz'
  homepage ''
  md5 'f4e78547c79ea8a8ad111cf8b85011bb'

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
    # `brew test libvisual`. Remove this comment before submitting
    # your pull request!
    system "false"
  end
end
