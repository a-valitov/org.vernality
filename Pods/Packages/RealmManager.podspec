Pod::Spec.new do |s|
  s.name             = 'RealmManager'
  s.version          = '0.0.1'
  s.summary          = 'Realm context.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.ios.source_files = 'RealmManager/**/*.{h,m,swift}', 'RealmManager/*.{h,m,swift}'
  s.exclude_files = 'RealmManager/Tests/*.*', 'RealmManager/Tests/**/*.*'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'RealmManager/Tests/**/*.{swift}', 'RealmManager/Tests/*.{swift}'
  end

  s.dependency 'RealmSwift', '=10.0.0-beta.2'
  
end

