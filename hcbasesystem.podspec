#
#  Be sure to run `pod spec lint HCCoren.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "hccoren"
  s.version      = "0.1.1"
  s.summary      = "这是一个与业务无关的特定的核心库。"
  s.description  = <<-DESC
这是一个特定的核心库。包含了常用的字串处理、网络处理、图片处理、压缩、正则、JSON、数据库及一个WebServer管理器。简化了外部引用的一些问题。
                   DESC

  s.homepage     = "https://github.com/halfking/hccoren"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "halfking" => "kimmy.huang@gmail.com" }
  # Or just: s.author    = ""
  # s.authors            = { "" => "" }
  # s.social_media_url   = "http://twitter.com/"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # s.platform     = :ios
   s.platform     = :ios, "7.0"

  #  When using multiple platforms
   s.ios.deployment_target = "7.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

s.source       = { :git => "https://github.com/halfking/hccoren.git", :tag => s.version,:submodules => true  }
#s.source       = { :git => "http://github.com/halfking/hccoren.git", :tag => s.version }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

# s.source_files  = "hccoren", "hccoren/**/regexkitlite.{h,m,mm}"
#  s.exclude_files = "hccoren/Exclude"

#s.public_header_files = "hccoren/**/regexkitlite.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "UIKit"
  # s.frameworks = "UIKit", "Foundation"

  # s.library   = "iconv"
#  s.libraries = "icucore","sqlite3.0","stdc++"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = false

    s.xcconfig = { "CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES" => "YES","ENABLE_BITCODE" => "YES","DEFINES_MODULE" => "YES" }
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
s.dependency "HCMinizip", "~> 1.2.6"

#  s.default_subspec = 'All'
#  s.subspec 'All' do |spec|
#	spec.ios.dependency 'hccoren/REGEXKITLITE' '~>0.0.5'
#    spec.ios.dependency 'hccoren/Core'          '~>0.0.5'
#spec.ios.dependency 'hccoren/AsyncSocket'
#  end
#    s.subspec 'Minizip' do |spec|
#        spec.requires_arc            = false
#        spec.source_files = "hccoren/ZipArchive/MiniZip/*.{h,m,mm,c,cpp}"
#        spec.public_header_files = [
#            'hccoren/ZipArchive/MiniZip/*.h'
#        ]

#        spec.libraries = [
#            "icucore","iconv","z"
#        ]
#    end
    s.subspec 'Core' do |spec|
        spec.requires_arc            = false
        spec.source_files = [
            "hccoren/String/**/*.{h,m,mm,c,cpp}",
            "hccoren/Util/**/*.{h,m,mm,c,cpp}",
#            "hccoren/ZipArchive/**/*.{h,m,mm,c,cpp}",
            "hccoren/Data/*.{h,m,c,cpp}",
            "hccoren/base/*.{h,m,mm,c,cpp}",
            "hccoren/**/config.h",
            "hccoren/**/Reachability.{h,m}",
            "hccoren/UDI/**/*.{h,m,cpp,c}",
            "hccoren/Map/*.{h,m}",
            "hccoren/base.h"
        ]
        spec.public_header_files = [
            'hccoren/String/**/*.h',
            'hccoren/Util/**/*.h',
#            'hccoren/ZipArchive/**/*.h',
            'hccoren/Data/*.h',
            'hccoren/Base/*.h',
            'hccoren/**/config.h',
            'hccoren/UDI/**/*.h',
            'hccoren/**/Reachability.h',
            'hccoren/Map/*.h',
            'hccoren/base.h'
        ]
        spec.exclude_files = [
            "hccoren/Util/HttpServerManager.{h,m,mm,c,cpp}",
            "hccoren/Util/HWWeakTimer.{h,m}",
            "hccoren/ZipArchive/**/*.{h,m,mm,c,cpp}",
            "hccoren/ZipArchive/MiniZip/*.{h,m,mm,c,cpp}",
            "hccoren/base/publictext.h"
        ]
        spec.libraries = [
            'icucore',
            'iconv',
            'stdc++',
            'stdc++.6',
            'z'
        ]
        spec.frameworks = [
            'UIKit',
            'CoreLocation',
            'QuartzCore',
            'OpenGLES',
            'SystemConfiguration',
            'CoreGraphics',
            'Security',
            'IOKit'
        ]
        #spec.ios.dependency 'HCMinizip' '~>1.2.6'
    end
    s.subspec 'NetworkAndDatabase' do |spec|
        spec.requires_arc            = true
        spec.source_files = [
            "hccoren/Network/AsyncSocket/*.{h,m,mm,cpp,c}",
            "hccoren/CMDBase/*.{h,m,mm,cpp,c}",
            "hccoren/Database/*.{h,m,mm,cpp,c}",
            "hccoren/Util/HttpServerManager.{h,m,mm,c,cpp}",
            "hccoren/Network/CocoaWebResource/*.{h,m,mm,c,cpp}",
            "hccoren/Network/BlueSession/*.{h,m,mm,c,cpp}",
            "hccoren/database.h",
            "hccoren/cmd.h"
        ]
        spec.public_header_files = [
            'hccoren/Network/AsyncSocket/*.h',
            'hccoren/CMDBase/*.h',
            'hccoren/Database/*.h',
            'hccoren/Network/CocoaWebResource/*.h',
            'hccoren/Network/BlueSession/*.h',
            'hccoren/Util/HttpServerManager.h',
            'hccoren/database.h',
            'hccoren/cmd.h'
        ]
        spec.libraries = [
            "stdc++",
            "stdc++.6","icucore","iconv","sqlite3.0"
        ]
        spec.ios.dependency 'hccoren/Core'
    end
    s.subspec 'UIControls' do |spec|
        spec.requires_arc            = true
        spec.source_files = [
            "hccoren/UIControls/*.{h,m,mm,cpp,c}",
            "hccoren/images.h"
        ]
        spec.public_header_files = [
            'hccoren/UIControls/*.h',
            'hccoren/images.h'
        ]
        spec.frameworks = [
            'UIKit',
            'CoreImage',
            'CoreGraphics',
            'QuartzCore',
            'OpenGLES',
            'SystemConfiguration'
        ]
        spec.ios.dependency 'hccoren/Core'
    end
 end
