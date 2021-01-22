Pod::Spec.new do |s|
  s.name             = 'Raise'
  s.version          = '0.0.1'
  s.summary          = 'Raise.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.default_subspecs = 'Sources'

  s.subspec 'Sources' do |ss|
    ss.source_files = 'Sources/**/*.{h,m,swift}', 'Sources/*.{h,m,swift}'
    s.dependency 'FittedSheets'
  end

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/**/*.{swift}', 'Tests/*.{swift}'
  end
end

