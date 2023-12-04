#
# Be sure to run `pod lib lint ShibaInu.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ShibaInu'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ShibaInu.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/oxleslie/ShibaInu'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'oxleslie' => 'oxleslie@qq.com' }
  s.source           = { :git => 'https://github.com/oxleslie/ShibaInu.git', :tag => s.version.to_s }

  # s.pod_target_xcconfig = { 'SWIFT_INCLUDE_PATHS' => ['${PODS_ROOT}/ShibaInu/Classes/Utils/ObjC'] }
  s.pod_target_xcconfig = { 'SWIFT_INCLUDE_PATHS' => '${PODS_TARGET_SRCROOT}/ShibaInu/Classes/Utils/ObjC' }

  s.platform = :osx
  s.osx.deployment_target = "10.10"
  s.static_framework = true

  s.source_files  = 'ShibaInu/Classes/**/*'
  s.exclude_files = 'ShibaInu/Classes/**/module.modulemap'
  s.private_header_files = 'ShibaInu/Classes/Utils/ObjC/*.h'

  # s.resource_bundles = {
  #   'ShibaInu' => ['ShibaInu/Assets/*.png']
  # }
end
