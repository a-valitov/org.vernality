Pod::Spec.new do |s|
  s.name             = 'PCSupplier'
  s.version          = '0.0.1'
  s.summary          = 'ProfitClub Supplier Module.'
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
    ss.resources = 'Sources/PCSupplier/Assets/PCSupplier.xcassets'

    ss.dependency 'PCModel'
    ss.dependency 'PCUserService'
    ss.dependency 'PCActionService'
    ss.dependency 'PCCommercialOfferService'
    ss.dependency 'ErrorPresenter'
    ss.dependency 'ConfirmationPresenter'
    ss.dependency 'ActivityPresenter'
    ss.dependency 'MenuPresenter'
  end

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/**/*.{swift}', 'Tests/*.{swift}'
  end
end



