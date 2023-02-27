Pod::Spec.new do |s|
  s.name                  = 'Layout'
  s.version               = '0.0.0'
  s.summary               = 'Tinder\'s UIKit Auto Layout API'
  s.description           = 'API for adding subviews and constraints to a view.'
  s.homepage              = 'https://github.com/Tinder/Layout'
  s.license               = ''
  s.author                = { 'Tinder' => 'info@gotinder.com' }
  s.source                = { :git => 'https://github.com/Tinder/Layout.git', :tag => s.version }
  s.social_media_url      = 'https://twitter.com/TinderEng'

  s.ios.deployment_target = '13.0'
  s.swift_version         = '5.5', '5.6', '5.7'
  s.source_files          = 'Sources/Layout/**/*'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/LayoutTests/**/*'
  end
end
