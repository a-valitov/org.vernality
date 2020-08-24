Pod::Spec.new do |s|
  s.name             = 'Channels'
  s.version          = '0.0.1'
  s.summary          = 'Channels module.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation', 'UIKit'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.ios.source_files = 'Channels/**/*.{h,m,swift}', 'Channels/*.{h,m,swift}'
  s.exclude_files = 'Channels/Tests/*.*', 'Channels/Tests/**/*.*'
  
  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Channels/Tests/**/*.{swift}', 'Channels/Tests/*.{swift}'
  end

  s.dependency 'TeleGuideModel'
  s.dependency 'ChannelReactor'
  s.dependency 'ChannelStorage'
  s.dependency 'ErrorPresenter'
  s.dependency 'ActivityPresenter'
end
