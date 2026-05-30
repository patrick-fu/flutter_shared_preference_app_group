#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint shared_preference_app_group.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'shared_preference_app_group'
  s.version          = '2.0.0'
  s.summary          = 'Shared preference supporting iOS App Group capability'
  s.description      = <<-DESC
Shared preference supporting iOS App Group capability
                       DESC
  s.homepage         = 'https://github.com/patrick-fu/flutter_shared_preference_app_group'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'shared_preference_app_group/Sources/shared_preference_app_group/**/*.{h,m}'
  s.exclude_files = 'shared_preference_app_group/Sources/shared_preference_app_group/PrivacyInfo.xcprivacy'
  s.public_header_files = 'shared_preference_app_group/Sources/shared_preference_app_group/include/**/*.h'
  s.ios.dependency 'Flutter'
  s.osx.dependency 'FlutterMacOS'
  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.resource_bundles = {'shared_preference_app_group_privacy' => ['shared_preference_app_group/Sources/shared_preference_app_group/PrivacyInfo.xcprivacy']}

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
