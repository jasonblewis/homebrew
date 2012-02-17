require 'formula'

class Xmltv < Formula
  url 'http://sourceforge.net/projects/xmltv/files/xmltv/0.5.61/xmltv-0.5.61.tar.bz2/download#'
  homepage 'http://wiki.xmltv.org/index.php/XMLTVProject'
  md5 '66607d44bfca0919dadeb4a41e45fcf8'
  version '0.5.61'
  
  # depends_on 'cmake'
  depends_on 'File::Slurp' => :perl   
  depends_on 'XML::Parser' => :perl   
  depends_on 'XML::Twig' => :perl   
  depends_on 'XML::Writer' => :perl   
  depends_on 'Lingua::EN::Numbers::Ordinate' => :perl   
  depends_on 'Lingua::Preferred' => :perl   
  depends_on 'Term::ProgressBar' => :perl   
  depends_on 'Unicode::String' => :perl   

  def install
    interactive_shell

    system "echo yes | perl Makefile.PL PREFIX=#{prefix}"
    system "make"
    system "make test"
    system "make install"
  end

  def test
    # This test will fail and we won't accept that! It's enough to just
    # replace "false" with the main program this formula installs, but
    # it'd be nice if you were more thorough. Test the test with
    # `brew test xmltv`. Remove this comment before submitting
    # your pull request!
    system "false"
  end
end
