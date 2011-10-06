require 'formula'

class Mythtv < Formula
  #url 'https://nodeload.github.com/MythTV/mythtv/tarball/fixes/0.24'
  url 'https://github.com/MythTV/mythtv.git', :branch => 'fixes/0.24'
  homepage 'http://www.mythtv.org'
  #md5 'd27c33d67ea8d5d5a6279f7b4844002c'
  version "0.24.fixes"

  head 'git://github.com/MythTV/mythtv.git'
    

  def caveats; <<-EOS.undent
  This script builds mythfrontend, mythbackend and the mythtv plugins. It defaults to installing .24-fixes branch but it does include a --HEAD option with caveates. 

  To build:
  1. mythtv requires qt with qt3support compiled in:
     > brew install qt --with-qt3support
  2. then build mythtv
     > brew install mythtv
 
  Currently brew has no way to install HEAD of a formula without requiring HEAD on all its dependencies.
  So to build mythtv HEAD requires HEAD of Qt which is undesireable.

  To build head:
  1. if you haveing already, build the fixes version of mythtv (to ensure all deps are satisfied)
     > brew install mythtv 
  2. then uninstall mythtv
     > brew uninstall mythtv
  3. then install mythtv head using
     > brew install --ignore-dependencies --HEAD mythtv

  Python dependencies:
    brew does not install python depencencies, for that it recomments easy_install
    however I found that easy_install often failed. try pip or simply manually download and install the python dependency

  Perl dependencies:
    Perl debencencies can be installed with cpan -i <module name>.

    EOS
  end



  #TODO
  # ensure SIMBL is installed

  #TODO
  # ensure file ~/Library/Application\
  # Support/SIMBL/Plugins/megazoomer.bundle/Contents/MacOS/megazoomer
  # | grep x86_64   returns something, ie megazoomer 64 bit is installed
  
  depends_on 'yasm'
  depends_on 'mysql'
  depends_on 'qt'
  depends_on 'pkg-config'
  # check also that qt was installed with the --enable-qt3support and  warn user if not:
  unless system 'pkg-config', '--exists', 'Qt3Support'; onoe 'No QT3 support in QT. Please reinstall qt with: brew install qt --with-qt3support'; exit 1 end
  depends_on 'lame'
  depends_on 'python'
  depends_on 'urlgrabber' => :python
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

  # for MythNetVision:
  depends_on 'pycurl' => :python
  depends_on 'oauth'  => :python

  # for MythWeather:
  depends_on 'XML::Simple' => :perl
  depends_on 'XML::XPath' => :perl
  depends_on 'Image::Size' => :perl
  depends_on 'DateTime::Format::ISO8601' => :perl
  depends_on 'SOAP::Lite' => :perl
  
  # for MythGallary
  depends_on 'exif'
  depends_on 'dcraw'

  # for MythMusic
  depends_on 'taglib'
  depends_on 'fftw'  
  # currently no formula to build libvisual and my attempts to build it failed
  # depends_on 'libvisual' 
 
  def install

    cd('mythtv')
    system "./configure", "--disable-debug", "--prefix=#{prefix}", "--disable-distcc",
          "--arch=x86_64",
      	  "--disable-firewire",
#          "--disable-iptv",
#          "--disable-hdhomerun",
#          "--disable-v4l",      
#          "--disable-ivtv",     
#          "--disable-hdpvr",    
#          "--disable-dvb",
#          "--disable-filters",
#          "--disable-avfilter",
#          "--with-bindings=",
#          "--enable-pic",
    "--cc=/usr/bin/gcc-4.2",
    "--cxx=/usr/bin/g++-4.2"
    system "make"
    
    #abort 'exiting for testing purposes'
    #raise 'exiting for testing purposes'
    #interactive_shell

    system "make install"
   
    cd('..')
  
    cd('mythplugins')  
    system "./configure",
    "--prefix=#{prefix}",
    "--arch=x86_64",

    "--enable-opengl",

    # MythArchive related options:
    "--enable-mytharchive",

    # MythBroswer realted options:
    "--enable-mythbrowser",

    # MythGallery related options:
    "--enable-mythgallery",
    "--enable-exif",
    "--enable-new-exif",
    "--enable-dcraw",
    
    # MythGame related options
    "--enable-mythgame", # build the mythgame plugin
    
    
    #  MythMusic related options:
    "--enable-mythmusic",
    "--enable-libvisual",
    "--enable-fftw",
    "--enable-sdl",
    
    # MythNetvision related options:
    "--enable-mythnetvision", #  build the mythnetvision plugin [yes]
    
    # MythNews related options:
    "--enable-mythnews",       # build the mythnews plugin [yes]
    
    # MythWeather related options:
    "--enable-mythweather",   #  build the mythweather plugin [yes]
    
    #  MythZoneMinder related options:
    "--enable-mythzoneminder" #  build the mythzoneminder plugin [yes]

    
    #interactive_shell

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
