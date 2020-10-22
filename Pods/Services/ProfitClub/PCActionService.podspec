Pod::Spec.new do |s|
  s.name             = 'PCActionService'
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

  s.ios.source_files = 'PCActionService/**/*.{h,m,swift}', 'PCActionService/*.{h,m,swift}'
  s.exclude_files = 'PCActionService/Tests/*.*', 'PCActionService/Tests/**/*.*'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'PCActionService/Tests/**/*.{swift}', 'PCActionService/Tests/*.{swift}'
  end

  s.dependency 'ProfitClubModel'
  s.dependency 'ProfitClubParse'
  s.dependency 'PCAuthentication'
  s.dependency 'Parse'
end

