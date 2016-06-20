#
#  Be sure to run `pod spec lint HCBaseSystem' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "HCBaseSystem"
  s.version      = "0.3.9"
  s.summary      = "这是一个与分享、推送、上传下载及用户、命令等的核心库。"
  s.description  = <<-DESC
这是一个特定的核心库。包含了常用的分享、命令、推送、上传、下载、及用户管理器。简化了外部引用的一些问题。
0.3.9   增加IsFirstLoad:(NString *)type 函数，用于记录指定的操作是否第一次进行
                   DESC

  s.homepage     = "https://github.com/halfking/HCBaseSystem"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

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

s.source       = { :git => "https://github.com/halfking/hcbasesystem.git", :tag => s.version,:submodules => true  }
#s.source       = { :git => "http://github.com/halfking/hcbasesystem.git", :tag => s.version }



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
  # s.frameworks = "UIKit", "Foundation","TencentOpenAPI"

  # s.library   = "iconv"
#  s.libraries = "icucore","sqlite3.0","stdc++"

  # s.requires_arc = false

s.xcconfig = { "CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES" => "YES","ENABLE_BITCODE" => "YES","DEFINES_MODULE" => "YES"}

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

    s.dependency "HCMinizip"
    s.dependency "hccoren"
    s.dependency "Qiniu", "~> 7.0"
    s.dependency "SDWebImage", "~>3.7.5"
    s.dependency "AFNetworking", "~>2.6.3"


    s.subspec 'Ver' do |spec|
        spec.requires_arc            = true
        spec.source_files = [
            "HCBaseSystem/iVersion/*.{h,m,mm,c,cpp}"
        ]
        spec.public_header_files = [
            'HCBaseSystem/iVersion/*.h'
        ]
#        spec.exclude_files = []
#        spec.libraries = []
        spec.frameworks = [
            'UIKit'
        ]
        #spec.ios.dependency 'HCMinizip' '~>1.2.6'
    end
    s.subspec 'UIControls' do |spec|
        spec.requires_arc            = true
        spec.source_files = [
            "HCBaseSystem/UIControls/**/*.{h,m,mm,cpp,c}",
            "HCBaseSystem/imagecontrols.h"
        ]
        spec.exclude_files = [
            "HCBaseSystem/UIControls/LoginViewNew.{h,m,mm,cpp,c}",
            "HCBaseSystem/UIControls/ShareView.{h,m,mm,cpp,c}",
#           "HCBaseSystem/UIControls/MBProgressHUD.{h,m,mm,cpp,c}"
        ]
        spec.public_header_files = [
            'HCBaseSystem/UIControls/**/*.h',
            'HCBaseSystem/imagecontrols.h'
        ]
        spec.frameworks = [
            'UIKit',
            'CoreImage',
            'CoreGraphics',
            'QuartzCore',
            'OpenGLES',
            'SystemConfiguration'
        ]
    end
    s.subspec 'User' do |spec|
        spec.requires_arc            = true
        spec.source_files = [
            "HCBaseSystem/CMDEX/*.{h,m,mm,cpp,c}",
            "HCBaseSystem/Users/*.{h,m,mm,cpp,c}",
            "HCBaseSystem/UpDown/*.{h,m,mm,cpp,c}",
            "HCBaseSystem/UpDown.h",
            "HCBaseSystem/User_WT.h",
            "HCBaseSystem/config.h",
            "HCBaseSystem/textresource.h",
#            "HCBaseSystem/Users/CMD_0001.{h,m}",
            "HCBaseSystem/cmd_wt.h",
            "HCBaseSystem/database_wt.h",
            "HCBaseSystem/PublicEnum.h"
        ]
        spec.public_header_files = [
            'HCBaseSystem/CMDEX/*.h',
            'HCBaseSystem/Users/*.h',
            "HCBaseSystem/UpDown/*.h",
            "HCBaseSystem/UpDown.h",
            'HCBaseSystem/User_WT.h',
            "HCBaseSystem/config.h",
            "HCBaseSystem/textresource.h",
#            'HCBaseSystem/Users/CMD_0001.h',
            'HCBaseSystem/cmd_wt.h',
            "HCBaseSystem/database_wt.h",
            "HCBaseSystem/PublicEnum.h"
        ]
        #spec.frameworks = []
    end
    s.subspec 'VDCManager' do |spec|
        spec.requires_arc            = true
        spec.source_files = [
            "HCBaseSystem/VDCManager/*.{h,m,mm,cpp,c}",
            "HCBaseSystem/vdc_f.h",
            "HCBaseSystem/vdc.h"
        ]
        spec.public_header_files = [
            "HCBaseSystem/VDCManager/*.h",
            "HCBaseSystem/vdc.h",
            "HCBaseSystem/vdc_f.h"
        ]
        s.exclude_files = [
            "HCBaseSystem/VDCManager/VDCLoaderConnection.{h,m,mm,cpp,c}",
            "HCBaseSystem/VDCManager/VDCTempFileManager(readerwrite).{h,m,mm,cpp,c}",
           "HCBaseSystem/VDCManager/VDCTempFileManager.{h,m,mm,cpp,c}"
        ]

        #spec.frameworks = []
        spec.ios.dependency 'HCBaseSystem/User'
    end
    s.subspec 'Comments' do |spec|
        spec.requires_arc            = true
        spec.source_files = [
            "HCBaseSystem/Comment/*.{h,m,mm,cpp,c}",
            "HCBaseSystem/comments_wt.h"
        ]
        spec.public_header_files = [
            "HCBaseSystem/Comment/*.h",
            "HCBaseSystem/comments_wt.h"
        ]
        #spec.frameworks = []
        spec.ios.dependency 'HCBaseSystem/User'
    end
 end
