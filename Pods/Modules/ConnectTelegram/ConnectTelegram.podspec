Pod::Spec.new do |s|
  s.name             = 'ConnectTelegram'
  s.version          = '0.0.1'
  s.summary          = 'ConnectTelegram module.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation', 'UIKit'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.ios.source_files = 'ConnectTelegram/**/*.{h,m,swift}', 'ConnectTelegram/*.{h,m,swift}'
  s.exclude_files = 'ConnectTelegram/Tests/*.*', 'ConnectTelegram/Tests/**/*.*'
  
  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'ConnectTelegram/Tests/**/*.{swift}', 'ConnectTelegram/Tests/*.{swift}'
  end

  s.dependency 'PhoneView'
  s.dependency 'CodeView'
  s.dependency 'PasswordView'
  s.dependency 'ErrorPresenter'
  s.dependency 'ActivityPresenter'
end
