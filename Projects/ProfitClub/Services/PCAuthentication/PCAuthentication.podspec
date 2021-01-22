Pod::Spec.new do |s|
  s.name             = 'PCAuthentication'
  s.version          = '0.0.1'
  s.summary          = 'ProfitClub authentication.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.default_subspecs = 'Contract'

  s.subspec 'Contract' do |ss|
    ss.source_files = 'Sources/PCAuthentication/**/*.{h,m,swift}', 'Sources/PCAuthentication/*.{h,m,swift}'
    ss.dependency 'PCModel'
  end

  s.subspec 'Parse' do |ss|
    ss.source_files = 'Sources/PCAuthenticationParse/**/*.{h,m,swift}', 'Sources/PCAuthenticationParse/*.{h,m,swift}'
    ss.dependency 'PCModel/Parse'
    ss.dependency 'Parse'
  end

  s.subspec 'Stub' do |ss|
    ss.source_files = 'Sources/Stub/**/*.{h,m,swift}', 'Sources/Stub/*.{h,m,swift}'
    ss.dependency 'PCModel'
  end

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/**/*.{swift}', 'Tests/*.{swift}'
  end

end

