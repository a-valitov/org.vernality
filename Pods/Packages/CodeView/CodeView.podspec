Pod::Spec.new do |s|
  s.name             = 'CodeView'
  s.version          = '0.0.1'
  s.summary          = 'Code view.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation', 'UIKit'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.ios.source_files = 'CodeView/**/*.{h,m,swift}', 'CodeView/*.{h,m,swift}'
  s.exclude_files = 'CodeView/Tests/*.*', 'CodeView/Tests/**/*.*'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'CodeView/Tests/**/*.{swift}', 'CodeView/Tests/*.{swift}'
  end
end

