Pod::Spec.new do |s|
  s.name             = 'FolderStorage'
  s.version          = '0.0.1'
  s.summary          = 'Folder storage.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.ios.source_files = 'FolderStorage/**/*.{h,m,swift}', 'FolderStorage/*.{h,m,swift}'
  s.exclude_files = 'FolderStorage/Tests/*.*', 'FolderStorage/Tests/**/*.*'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'FolderStorage/Tests/**/*.{swift}', 'FolderStorage/Tests/*.{swift}'
  end

  s.dependency 'RealmManager'
  s.dependency 'RealmSwift'
  s.dependency 'TeleGuideModel'
  s.dependency 'TeleGuideRealm'
end

