Pod::Spec.new do |s|
  s.name             = 'PCUserService'
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
    ss.source_files = 'Sources/PCUserService/**/*.{h,m,swift}', 'Sources/PCUserService/*.{h,m,swift}'
    ss.dependency 'PCModel'
  end

  s.subspec 'Parse' do |ss|
    ss.source_files = 'Sources/PCUserServiceParse/**/*.{h,m,swift}', 'Sources/PCUserServiceParse/*.{h,m,swift}'
    ss.dependency 'PCUserPersistence'
    ss.dependency 'PCModel/Parse'
    ss.dependency 'Parse'
  end

  s.subspec 'Stub' do |ss|
    ss.source_files = 'Sources/PCUserServiceStub/**/*.{h,m,swift}', 'Sources/PCUserServiceStub/*.{h,m,swift}'
    ss.dependency 'PCUserPersistenceStub'
    ss.dependency 'PCModel'
  end

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/**/*.{swift}', 'Tests/*.{swift}'
  end
end

