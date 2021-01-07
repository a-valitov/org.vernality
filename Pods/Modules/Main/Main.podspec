Pod::Spec.new do |s|
  s.name             = 'Main'
  s.version          = '0.0.1'
  s.summary          = 'Main (navigation) module.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation', 'UIKit'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.ios.source_files = 'Sources/**/*.{h,m,swift}', 'Sources/*.{h,m,swift}'
  
  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/**/*.{swift}', 'Tests/*.{swift}'
  end

  s.dependency 'FittedSheets', '~> 2.2.3'
end