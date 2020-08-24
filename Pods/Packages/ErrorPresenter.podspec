Pod::Spec.new do |s|
  s.name             = 'ErrorPresenter'
  s.version          = '0.0.1'
  s.summary          = 'Error presenter.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.ios.source_files = 'ErrorPresenter/**/*.{h,m,swift}', 'ErrorPresenter/*.{h,m,swift}'
  s.exclude_files = 'ErrorPresenter/Tests/*.*', 'ErrorPresenter/Tests/**/*.*'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'ErrorPresenter/Tests/**/*.{swift}', 'ErrorPresenter/Tests/*.{swift}'
  end
end

