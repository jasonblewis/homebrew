require 'formula'

class Mythtv < Formula
  url 'https://nodeload.github.com/MythTV/mythtv/tarball/fixes/0.24'
  homepage 'http://www.mythtv.org'
  md5 'd27c33d67ea8d5d5a6279f7b4844002c'
  version "0.24.1"

  depends_on 'yasm'
  depends_on 'mysql'
  depends_on 'qt'
  depends_on 'lame'
  depends_on 'python'
  depends_on 'DBI' => :perl   # cpan DBI
  depends_on 'Net::UPnP::QueryResponse' => :perl    # cpan Net::UPnP::QueryResponse
  depends_on 'Net::UPnP::ControlPoint' => :perl   # sudo easy_install lxml    until i find a better way
  depends_on 'lxml' => :python

  def install

    cd('mythtv')
    system "./configure", "--disable-debug", "--prefix=#{prefix}", "--disable-distcc",
          "--arch=x86_64",
      	  "--disable-firewire",
          "--disable-iptv",
          "--disable-hdhomerun",
          "--disable-v4l",      
          "--disable-ivtv",     
          "--disable-hdpvr",    
          "--disable-dvb"
        
    system "make install"
    cd('..')
  end

  def test
    # this will fail we won't accept that, make it test the program works!
    system "/usr/bin/false"
  end
end
