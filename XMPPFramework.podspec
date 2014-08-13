Pod::Spec.new do |s|
  s.name = 'XMPPFramework'
  s.version = '0.1.1'
  s.license = { :type => 'BSD', :file => 'copying.txt' }
  s.summary = 'An XMPP Framework in Objective-C for the Mac / iOS development community.'
  s.homepage = 'https://github.com/robbiehanson/XMPPFramework'
  s.author = { 'Robbie Hanson' => 'robbiehanson@deusty.com' }
  s.source = { :git => 'https://github.com/songlin/XMPPFramework' }

  s.description = 'XMPPFramework provides a core implementation of RFC-3920 (the xmpp standard), along with
                  the tools needed to read & write XML. It comes with multiple popular extensions (XEP\'s),
                  all built atop a modular architecture, allowing you to plug-in any code needed for the job.
                  Additionally the framework is massively parallel and thread-safe. Structured using GCD,
                  this framework performs well regardless of whether it\'s being run on an old iPhone, or
                  on a 12-core Mac Pro. (And it won\'t block the main thread... at all).'
  s.requires_arc = true
  s.source_files = 'XMPPFramework.h'

  s.subspec 'Core' do |core|
    core.source_files = 'Core/**/*.{h,m}','Vendor/libidn/*.h'
    core.resource = "Vendor/libidn/libidn.a"
    core.libraries = 'xml2','resolv','idn'
    core.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2 $(SDKROOT)/usr/include/libresolv',
                      'LIBRARY_SEARCH_PATHS' => '$(PODS_ROOT)/XMPPFramework/Vendor/libidn'}

    core.dependency 'XMPPFramework/Authentication'
    core.dependency 'XMPPFramework/Categories'
    core.dependency 'XMPPFramework/Utilities'
    core.dependency 'XMPPFramework/Extensions'
    core.ios.dependency 'XMPPFramework/KissXML'
    core.dependency 'CocoaLumberjack'
    core.dependency 'CocoaAsyncSocket'
  end

  s.subspec 'Authentication' do |authentication|
    authentication.source_files =  'Authentication/**/*.{h,m}'
    authentication.dependency 'XMPPFramework/Core'
  end

  s.subspec 'Categories' do |categories|
    categories.source_files =  'Categories/**/*.{h,m}'
    categories.dependency 'XMPPFramework/Core'
  end

  s.subspec 'Extensions' do |extensions|
    extensions.source_files = 'Extensions/**/*.{h,m}'
    extensions.dependency 'XMPPFramework/Core'
  end

  s.subspec 'Utilities' do |utilities|
    utilities.source_files =  'Utilities/**/*.{h,m}'
    utilities.dependency 'XMPPFramework/Core'
  end

  s.subspec 'KissXML' do |kissxml|
    kissxml.source_files = 'Vendor/KissXML/**/*.{h,m}'
    kissxml.dependency 'XMPPFramework/Core'
  end

  s.pre_install do |pod_representation, library_representation|
    Dir.chdir(pod_representation.root) do
      system 'if [ -e Sample_XMPPFramework.h ]; then mv Sample_XMPPFramework.h XMPPFramework.h; fi'
    end
  end

end
