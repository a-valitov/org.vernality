Pod::Spec.new do |s|
  s.name             = 'FoldersView'
  s.version          = '0.0.1'
  s.summary          = 'Folders view.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation', 'UIKit'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.ios.source_files = 'FoldersView/**/*.{h,m,swift}', 'FoldersView/*.{h,m,swift}'
  s.exclude_files = 'FoldersView/Tests/*.*', 'FoldersView/Tests/**/*.*'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'FoldersView/Tests/**/*.{swift}', 'FoldersView/Tests/*.{swift}'
  end

  s.ios.dependency 'Folders'
  
end

