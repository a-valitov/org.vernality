Pod::Spec.new do |s|
  s.name             = 'PCOrganization'
  s.version          = '0.0.1'
  s.summary          = 'ProfitClub organization module.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.default_subspecs = 'PCOrganization'

  s.subspec 'PCOrganization' do |ss|
    ss.source_files = 'Sources/PCOrganization/**/*.{h,m,swift}', 'Sources/PCOrganization/*.{h,m,swift}'
    ss.resources = 'Sources/PCOrganization/Assets/PCOrganization.xcassets'

    ss.dependency 'Raise'
    ss.dependency 'PCModel'
    ss.dependency 'PCUserService'
    ss.dependency 'PCOrganizationService'
    ss.dependency 'MenuPresenter'
    ss.dependency 'ErrorPresenter'
    ss.dependency 'ConfirmationPresenter'
    ss.dependency 'ActivityPresenter'

    ss.dependency 'PCOrganization/PCOrganizationAction'
    ss.dependency 'PCOrganization/PCOrganizationActions'
    ss.dependency 'PCOrganization/PCOrganizationCommercialOffer'
    ss.dependency 'PCOrganization/PCOrganizationCommercialOffers'
    ss.dependency 'PCOrganization/PCOrganizationMembers'
  end

  s.subspec 'PCOrganizationAction' do |ss|
    ss.source_files = 'Sources/PCOrganizationAction/**/*.{h,m,swift}', 'Sources/PCOrganizationAction/*.{h,m,swift}'
    ss.resources = 'Sources/PCOrganizationAction/Assets/PCOrganizationAction.xcassets'

    ss.dependency 'PCModel'
    ss.dependency 'PCActionService'
    ss.dependency 'PCUserService'
    ss.dependency 'PCOrganizationService'
    ss.dependency 'MenuPresenter'
    ss.dependency 'ErrorPresenter'
    ss.dependency 'ConfirmationPresenter'
    ss.dependency 'ActivityPresenter'
  end

  s.subspec 'PCOrganizationActions' do |ss|
    ss.source_files = 'Sources/PCOrganizationActions/**/*.{h,m,swift}', 'Sources/PCOrganizationActions/*.{h,m,swift}'
    ss.resources = 'Sources/PCOrganizationActions/Assets/PCOrganizationActions.xcassets'

    ss.dependency 'PCModel'
    ss.dependency 'PCUserService'
    ss.dependency 'PCOrganizationService'
    ss.dependency 'MenuPresenter'
    ss.dependency 'ErrorPresenter'
    ss.dependency 'ConfirmationPresenter'
    ss.dependency 'ActivityPresenter'
  end

  s.subspec 'PCOrganizationCommercialOffer' do |ss|
    ss.source_files = 'Sources/PCOrganizationCommercialOffer/**/*.{h,m,swift}', 'Sources/PCOrganizationCommercialOffer/*.{h,m,swift}'
    ss.resources = 'Sources/PCOrganizationCommercialOffer/Assets/PCOrganizationCommercialOffer.xcassets'

    ss.dependency 'PCModel'
    ss.dependency 'PCUserService'
    ss.dependency 'PCOrganizationService'
    ss.dependency 'PCCommercialOfferService'
    ss.dependency 'MenuPresenter'
    ss.dependency 'ErrorPresenter'
    ss.dependency 'ConfirmationPresenter'
    ss.dependency 'ActivityPresenter'
  end

  s.subspec 'PCOrganizationCommercialOffers' do |ss|
    ss.source_files = 'Sources/PCOrganizationCommercialOffers/**/*.{h,m,swift}', 'Sources/PCOrganizationCommercialOffers/*.{h,m,swift}'
    ss.resources = 'Sources/PCOrganizationCommercialOffers/Assets/PCOrganizationCommercialOffers.xcassets'

    ss.dependency 'PCModel'
    ss.dependency 'PCUserService'
    ss.dependency 'PCOrganizationService'
    ss.dependency 'MenuPresenter'
    ss.dependency 'ErrorPresenter'
    ss.dependency 'ConfirmationPresenter'
    ss.dependency 'ActivityPresenter'
  end

  s.subspec 'PCOrganizationMembers' do |ss|
    ss.source_files = 'Sources/PCOrganizationMembers/**/*.{h,m,swift}', 'Sources/PCOrganizationMembers/*.{h,m,swift}'
    ss.resources = 'Sources/PCOrganizationMembers/Assets/PCOrganizationMembers.xcassets'

    ss.dependency 'PCModel'
    ss.dependency 'Kingfisher'
    ss.dependency 'PCUserService'
    ss.dependency 'PCOrganizationService'
    ss.dependency 'MenuPresenter'
    ss.dependency 'ErrorPresenter'
    ss.dependency 'ConfirmationPresenter'
    ss.dependency 'ActivityPresenter'
  end

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/**/*.{swift}', 'Tests/*.{swift}'
  end
end



