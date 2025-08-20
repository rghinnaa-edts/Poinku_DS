Pod::Spec.new do |spec|
  spec.name             = "Poinku_DS"
  spec.version          = "0.1.1"
  spec.summary          = "UI Components and Animation"
  spec.description      = "UI Components and Animation of Poinku Apps"

  spec.homepage         = "https://github.com/rghinnaa-edts/Poinku-DS"
  spec.license          = { :type => "MIT", :file => "LICENSE" }
  spec.author           = { "Rizka Ghinna" => "rizka.ghinna@sg-dsa.com" }

  spec.platform		= :ios, "12.0"
  spec.swift_version	= "5.0"

  spec.source           = { :git => "https://github.com/rghinnaa-edts/Poinku_DS.git", :tag => spec.version.to_s }
  spec.source_files	= "Poinku_DS/**/*.{h,m,swift}"
 spec.resources		= "Poinku_DS/**/*.{xib,storyboard,xcassets,png,jpg,jpeg}"
  
  spec.frameworks	= "UIKit"
end
