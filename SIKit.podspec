Pod::Spec.new do |s|

  s.name         = "SIKit"
  s.version      = "0.1.1"
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

  s.source       = { :git => "https://github.com/khemarin/SIKit.git", :tag => "0.1.1-beta" }


  s.source_files  = "SIKit", "SIKit/SIKit/**/*.{h,m}"

  s.public_header_files = "SIKit/**/*.h"

end
