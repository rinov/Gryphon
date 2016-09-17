Pod::Spec.new do |s|
  s.name             = 'Gryphon'
  s.version          = '0.1.0'
  s.summary          = 'Type safe and useful API kit for Alamofire'

  s.homepage         = 'https://github.com/rinov/Gryphon'
  s.license          = { :type => 'Apache License 2.0', :file => 'LICENSE' }
  s.author           = { 'Ryo Ishikawa' => 'rinov@rinov.jp' }
  s.source           = { :git => 'https://github.com/rinov/Gryphon.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Gryphon/**/*'
  s.dependency 'Alamofire', '~> 3.0'

end
