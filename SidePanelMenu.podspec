#
#  Be sure to run `pod spec lint SidePanelMenu.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "SidePanelMenu"
  s.version      = "0.0.8"
  s.summary      = "It gives an Android style side panel menu."
  s.description  = "It gives an Android style side panel menu. you can set the different properties of SideMenuView like `backGroundColor`, `separatorColor `, `separatorType `, `transparentViewMargin ` etc if you need to customize it otherwise it will take default values."

  s.homepage     = "https://github.com/pjanoti/SidePanelMenu"
  s.screenshot   = "https://github.com/pjanoti/SidePanelMenu/img.png"

  #s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  
  s.author             = { "pjanoti@altimetrik.com" => "pjanoti@altimetrik.com" }

  s.platform     = :ios
  s.ios.deployment_target = '9.0'

  s.source       = { :git => "https://github.com/pjanoti/SidePanelMenu.git", :branch => "master", :tag => s.version }

  #  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.source_files = "Classes/**/*.{swift}"
  
  # s.public_header_files = "Classes/**/*.h"

  # s.resource  = "img.png"
  # s.resources = "Resources/*.png"
   s.resources = "Classes/**/*.{png,xib}"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # s.framework  = "SomeFramework"
   s.frameworks  = "Foundation", "UIKit"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
