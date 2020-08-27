Pod::Spec.new do |s|
  s.name             = 'ProfitClubParse'
  s.version          = '0.0.1'
  s.summary          = 'App parse model.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.ios.source_files = 'ProfitClubParse/**/*.{h,m,swift}', 'ProfitClubParse/*.{h,m,swift}'
  s.exclude_files = 'ProfitClubParse/Tests/*.*', 'ProfitClubParse/Tests/**/*.*'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'ProfitClubParse/Tests/**/*.{swift}', 'ProfitClubParse/Tests/*.{swift}'
  end

  s.dependency 'ProfitClubModel'
  s.dependency 'Parse'
end

