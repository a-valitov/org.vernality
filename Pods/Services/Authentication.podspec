Pod::Spec.new do |s|
  s.name             = 'Authentication'
  s.version          = '0.0.1'
  s.summary          = 'Authentication service.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.ios.source_files = 'Authentication/**/*.{h,m,swift}', 'Authentication/*.{h,m,swift}'
  s.exclude_files = 'Authentication/Tests/*.*', 'Authentication/Tests/**/*.*'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Authentication/Tests/**/*.{swift}', 'Authentication/Tests/*.{swift}'
  end

  s.dependency 'UserModel'
  s.dependency 'RealmManager'
  s.dependency 'RealmSwift'
end

