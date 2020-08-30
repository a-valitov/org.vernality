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

  s.ios.source_files = 'PCAuthentication/**/*.{h,m,swift}', 'PCAuthentication/*.{h,m,swift}'
  s.exclude_files = 'PCAuthentication/Tests/*.*', 'PCAuthentication/Tests/**/*.*'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'PCAuthentication/Tests/**/*.{swift}', 'PCAuthentication/Tests/*.{swift}'
  end

  s.dependency 'ProfitClubModel'
  s.dependency 'ProfitClubParse'
  s.dependency 'Parse'
end
