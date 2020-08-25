Pod::Spec.new do |s|
  s.name             = 'Login'
  s.version          = '0.0.1'
  s.summary          = 'Login (or register) module.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation', 'UIKit'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.ios.source_files = 'Login/**/*.{h,m,swift}', 'Login/*.{h,m,swift}'
  s.exclude_files = 'Login/Tests/*.*', 'Login/Tests/**/*.*'
  
  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Login/Tests/**/*.{swift}', 'Login/Tests/*.{swift}'
  end

  s.dependency 'LoginView'
  s.dependency 'UserModel'
  s.dependency 'Authentication'
  s.dependency 'ErrorPresenter'
  s.dependency 'ActivityPresenter'
end
