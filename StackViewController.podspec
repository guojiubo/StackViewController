Pod::Spec.new do |s|

  s.name         = "StackViewController"
  s.version      = "1.0.1"
  s.summary      = "A UINavigationController like custom container view controller which provides fullscreen pan gesture support to POP and PUSH"
  s.homepage     = "https://github.com/guojiubo/StackViewController"
  s.license      = "MIT"

  s.author             = { "guojiubo" => "guojiubo@gmail.com" }
  s.platform     = :ios
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/guojiubo/StackViewController.git", :tag => "1.0.1" }

  s.source_files  = "StackViewController", "StackViewController/*.{swift}"

  s.frameworks = "Foundation", "UIKit"

end
