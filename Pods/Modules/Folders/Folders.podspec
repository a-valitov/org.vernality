Pod::Spec.new do |s|
  s.name             = 'Folders'
  s.version          = '0.0.1'
  s.summary          = 'Folders module.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation', 'UIKit'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.ios.source_files = 'Folders/**/*.{h,m,swift}', 'Folders/*.{h,m,swift}'
  s.exclude_files = 'Folders/Tests/*.*', 'Folders/Tests/**/*.*'
  
  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Folders/Tests/**/*.{swift}', 'Folders/Tests/*.{swift}'
  end

  s.dependency 'TeleGuideModel'
  s.dependency 'Authentication'
  s.dependency 'FolderReactor'
  s.dependency 'FolderStorage'
  s.dependency 'ErrorPresenter'
  s.dependency 'ActivityPresenter'
end
