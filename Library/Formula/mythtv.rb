require 'formula'

class Mythtv < Formula
  url 'https://nodeload.github.com/MythTV/mythtv/tarball/fixes/0.24'
  homepage 'http://www.mythtv.org'
  md5 'd27c33d67ea8d5d5a6279f7b4844002c'
  version "0.24.1"

  head 'git://github.com/MythTV/mythtv.git'
  
  depends_on 'yasm'
  depends_on 'mysql'
  depends_on 'qt'
  # check also that qt was installed with the --enable-qt3support and  warn user if not:
  unless system 'pkg-config', '--exists', 'Qt3Support'; onoe 'No QT3 support in QT. Please reinstall qt with: brew install qt --with-qt3support'; exit 1 end
  depends_on 'lame'
  depends_on 'python'
  depends_on 'DBI' => :perl   # cpan DBI
  depends_on 'DBD::mysql' => :perl   
  depends_on 'Date::Manip' => :perl  
  depends_on 'Net::UPnP::QueryResponse' => :perl    # cpan Net::UPnP::QueryResponse
  depends_on 'Net::UPnP::ControlPoint' => :perl   # sudo easy_install lxml    until i find a better way
  depends_on 'ExtUtils::Install' => :perl
  
  # needed for the perl bindings
  depends_on 'Exporter'         => :perl
  depends_on 'Config'           => :perl
  depends_on 'Fcntl'            => :perl
  depends_on 'File::Copy'       => :perl
  depends_on 'HTTP::Request'    => :perl
  depends_on 'IO::Socket::INET' => :perl
  depends_on 'LWP::UserAgent'   => :perl
  depends_on 'Sys::Hostname'    => :perl
  

  
  depends_on 'lxml' => :python

  def install

    cd('mythtv')
    system "./configure", "--disable-debug", "--prefix=#{prefix}", "--disable-distcc",
          "--arch=x86_64",
      	  "--disable-firewire",
##          "--disable-iptv",
#          "--disable-hdhomerun",
#          "--disable-v4l",      
#          "--disable-ivtv",     
#          "--disable-hdpvr",    
#          "--disable-dvb",
          "--disable-filters",
          "--disable-avfilter",
          "--with-bindings=",
#          "--disable-yasm",
#    "--enable-pic",
    "--cc=/usr/bin/gcc-4.2",
    "--cxx=/usr/bin/g++-4.2"
    system "make"
    
    #abort 'exiting for testing purposes'
    #raise 'exiting for testing purposes'
    #interactive_shell

    system "make install"
   
     cd('..')
  end

  def test
    # this will fail we won't accept that, make it test the program works!
    system "/usr/bin/false"
  end
end
