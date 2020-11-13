Pod::Spec.new do |spec|
  spec.name          = 'ADKeyboardManager'
  spec.version       = '6.0.0'
  spec.authors       = 'Applidium'
  spec.license       = 'none'
  spec.homepage      = 'http://applidium.com'
  spec.summary       = 'Applidium\'s keyboard manager for ScrollViews'
  spec.platform      = 'ios', '10.0'
  spec.license       = { :type => 'Commercial', :text => 'Created and licensed by Applidium. Copyright 2016 Applidium. All rights reserved.' }
  spec.source        = { :git => 'https://github.com/faberNovel/ADKeyboardManager.git', :tag => "v#{spec.version}" }
  spec.source_files  = 'Classes/*.swift'
  spec.framework     = 'Foundation', 'UIKit'
  spec.requires_arc  = true
  spec.swift_version = '5.0'
end
