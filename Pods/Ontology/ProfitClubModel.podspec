Pod::Spec.new do |s|
  s.name             = 'ProfitClubModel'
  s.version          = '0.0.1'
  s.summary          = 'App onthology.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.ios.source_files = 'ProfitClubModel/**/*.{h,m,swift}', 'ProfitClubModel/*.{h,m,swift}'
  s.exclude_files = 'ProfitClubModel/Tests/*.*', 'ProfitClubModel/Tests/**/*.*'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'ProfitClubModel/Tests/**/*.{swift}', 'ProfitClubModel/Tests/*.{swift}'
  end

end

