Pod::Spec.new do |s|
  s.name             = 'PoinkuDesignKit'
  s.version          = '0.1.0'
  s.summary          = 'Set of Design Kits and Components of Poinku iOS App.'
  s.description      = 'This library provides a set of Design Kits and Components designed for Poinku Project use in iOS development. The library is currently under development, with ongoing efforts to expand its features and improve stability.'
  s.homepage         = 'https://github.com/rghinnaa-edts/Poinku-DS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Rizka Ghinna' => 'rizka.ghinna@sg-edts.com' }
  s.source           = { :git => 'https://github.com/rghinnaa-edts/Poinku-DS.git', :tag => '0.1.0' }
  
  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  
  s.source_files = 'Poinku-DS/Component/**/*'

  s.frameworks = 'UIKit'
end
