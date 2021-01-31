Pod::Spec.new do |s|
  s.name             = 'BundleUtils'
  s.version          = '0.0.1'
  s.summary          = 'Bundle utils.'
  s.homepage         = 'https://vernality.org'
  s.author           = { 'Rinat Enikeev' => 'rinat.enikeev@gmail.com' }
  s.license          = { :type => 'GPL', :file => '../../LICENSE' }
  s.platform         = :ios, '11.0'
  s.source           = { git: '' }
  s.frameworks       = 'Foundation'
  s.requires_arc     = true
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.ios.source_files = 'Sources/**/*.{h,m,swift}', 'Sources/*.{h,m,swift}'
end


