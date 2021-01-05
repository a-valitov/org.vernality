Pod::Spec.new do |s|
  s.name             = 'PhoneView'
  s.version          = '0.0.1'
  s.summary          = 'Phone view.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation', 'UIKit'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.ios.source_files = 'PhoneView/**/*.{h,m,swift}', 'PhoneView/*.{h,m,swift}'
  s.exclude_files = 'PhoneView/Tests/*.*', 'PhoneView/Tests/**/*.*'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'PhoneView/Tests/**/*.{swift}', 'PhoneView/Tests/*.{swift}'
  end

  s.ios.dependency 'PhoneNumberKit'
  s.ios.dependency 'CountryPickerSwift'  
end

