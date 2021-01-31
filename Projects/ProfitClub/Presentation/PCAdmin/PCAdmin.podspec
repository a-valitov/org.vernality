Pod::Spec.new do |s|
  s.name             = 'PCAdmin'
  s.version          = '0.0.1'
  s.summary          = 'ProfitClub admin module.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.default_subspecs = 'PCAdmin'

  s.subspec 'PCAdmin' do |ss|
    ss.source_files = 'Sources/PCAdmin/**/*.{h,m,swift}', 'Sources/PCAdmin/*.{h,m,swift}'
    ss.resource_bundles = {
        'PCAdmin' => ['Sources/**/Assets/*.xcassets']
    }

    ss.dependency 'BundleUtils'
    ss.dependency 'Raise'
    ss.dependency 'PCModel'
    ss.dependency 'PCUserService'
    ss.dependency 'PCOrganizationService'
    ss.dependency 'MenuPresenter'
    ss.dependency 'ErrorPresenter'
    ss.dependency 'ConfirmationPresenter'
    ss.dependency 'ActivityPresenter'
    ss.dependency 'PCFontProvider'

    ss.dependency 'PCAdmin/PCAdminAction'
    ss.dependency 'PCAdmin/PCAdminActions'
    ss.dependency 'PCAdmin/PCAdminCommercialOffer'
    ss.dependency 'PCAdmin/PCAdminCommercialOffers'
    ss.dependency 'PCAdmin/PCAdminOrganization'
    ss.dependency 'PCAdmin/PCAdminOrganizations'
    ss.dependency 'PCAdmin/PCAdminSupplier'
    ss.dependency 'PCAdmin/PCAdminSuppliers'
  end

  s.subspec 'PCAdminAction' do |ss|
    ss.source_files = 'Sources/PCAdminAction/**/*.{h,m,swift}', 'Sources/PCAdminAction/*.{h,m,swift}'

    ss.dependency 'BundleUtils'
    ss.dependency 'PCModel'
    ss.dependency 'PCActionService'
    ss.dependency 'PCUserService'
    ss.dependency 'PCOrganizationService'
    ss.dependency 'MenuPresenter'
    ss.dependency 'ErrorPresenter'
    ss.dependency 'ConfirmationPresenter'
    ss.dependency 'ActivityPresenter'
  end

  s.subspec 'PCAdminActions' do |ss|
    ss.source_files = 'Sources/PCAdminActions/**/*.{h,m,swift}', 'Sources/PCAdminActions/*.{h,m,swift}'

    ss.dependency 'BundleUtils'
    ss.dependency 'PCModel'
    ss.dependency 'PCUserService'
    ss.dependency 'PCOrganizationService'
    ss.dependency 'MenuPresenter'
    ss.dependency 'ErrorPresenter'
    ss.dependency 'ConfirmationPresenter'
    ss.dependency 'ActivityPresenter'
  end

  s.subspec 'PCAdminCommercialOffer' do |ss|
    ss.source_files = 'Sources/PCAdminCommercialOffer/**/*.{h,m,swift}', 'Sources/PCAdminCommercialOffer/*.{h,m,swift}'

    ss.dependency 'BundleUtils'
    ss.dependency 'PCModel'
    ss.dependency 'PCUserService'
    ss.dependency 'PCOrganizationService'
    ss.dependency 'PCCommercialOfferService'
    ss.dependency 'MenuPresenter'
    ss.dependency 'ErrorPresenter'
    ss.dependency 'ConfirmationPresenter'
    ss.dependency 'ActivityPresenter'
  end

  s.subspec 'PCAdminCommercialOffers' do |ss|
    ss.source_files = 'Sources/PCAdminCommercialOffers/**/*.{h,m,swift}', 'Sources/PCAdminCommercialOffers/*.{h,m,swift}'

    ss.dependency 'BundleUtils'
    ss.dependency 'PCModel'
    ss.dependency 'PCUserService'
    ss.dependency 'PCOrganizationService'
    ss.dependency 'MenuPresenter'
    ss.dependency 'ErrorPresenter'
    ss.dependency 'ConfirmationPresenter'
    ss.dependency 'ActivityPresenter'
  end

  s.subspec 'PCAdminOrganization' do |ss|
    ss.source_files = 'Sources/PCAdminOrganization/**/*.{h,m,swift}', 'Sources/PCAdminOrganization/*.{h,m,swift}'

    ss.dependency 'BundleUtils'
    ss.dependency 'PCModel'
    ss.dependency 'PCUserService'
    ss.dependency 'PCOrganizationService'
    ss.dependency 'MenuPresenter'
    ss.dependency 'ErrorPresenter'
    ss.dependency 'ConfirmationPresenter'
    ss.dependency 'ActivityPresenter'
  end

  s.subspec 'PCAdminOrganizations' do |ss|
    ss.source_files = 'Sources/PCAdminOrganizations/**/*.{h,m,swift}', 'Sources/PCAdminOrganizations/*.{h,m,swift}'

    ss.dependency 'BundleUtils'
    ss.dependency 'Kingfisher'
    ss.dependency 'PCModel'
    ss.dependency 'PCUserService'
    ss.dependency 'PCOrganizationService'
    ss.dependency 'MenuPresenter'
    ss.dependency 'ErrorPresenter'
    ss.dependency 'ConfirmationPresenter'
    ss.dependency 'ActivityPresenter'
  end

  s.subspec 'PCAdminSupplier' do |ss|
    ss.source_files = 'Sources/PCAdminSupplier/**/*.{h,m,swift}', 'Sources/PCAdminSupplier/*.{h,m,swift}'

    ss.dependency 'BundleUtils'
    ss.dependency 'PCModel'
    ss.dependency 'PCSupplierService'
    ss.dependency 'PCUserService'
    ss.dependency 'PCOrganizationService'
    ss.dependency 'MenuPresenter'
    ss.dependency 'ErrorPresenter'
    ss.dependency 'ConfirmationPresenter'
    ss.dependency 'ActivityPresenter'
  end

  s.subspec 'PCAdminSuppliers' do |ss|
    ss.source_files = 'Sources/PCAdminSuppliers/**/*.{h,m,swift}', 'Sources/PCAdminSuppliers/*.{h,m,swift}'

    ss.dependency 'BundleUtils'
    ss.dependency 'PCModel'
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



