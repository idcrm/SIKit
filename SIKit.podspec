Pod::Spec.new do |s|

  s.name         = "SIKit"
  s.version      = "0.1.3"
  s.summary      = "Simple interface form control"

  s.homepage     = "https://github.com/khemarin/SIKit"

  s.license      = "MIT"

  s.author             = { "Khemarin" => "loch_khemarin@yahoo.com" }

  s.platform     = :ios
  s.platform     = :ios, "8.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/khemarin/SIKit.git", :tag => "0.1.3"}


  s.source_files  = "SIKit/SIKit/**/*.{h,m}"
  s.resource_bundle = {"SIKit" => "SIKit/SIKit/**/*.{xib,storyboard}"}

  s.public_header_files = "SIKit/SIKit/SIKit.h", "SIKit/SIKit/**/*.h"

end
