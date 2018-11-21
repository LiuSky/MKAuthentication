#
# Be sure to run `pod lib lint MKAuthentication.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKAuthentication'
  s.version          = '0.1.0'
  s.summary          = 'TouchID And FaceID'
  s.homepage         = 'https://github.com/LiuSky/MKAuthentication'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sky' => '327847390@qq.com' }
  s.source           = { :git => 'https://github.com/LiuSky/MKAuthentication.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'MKAuthentication/Classes/**/*'
end
