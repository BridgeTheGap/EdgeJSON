#
# Be sure to run `pod lib lint EdgeJSON.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EdgeJSON'
  s.version          = '0.1.0'
  s.summary          = 'A set of extensions for JSON type'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
EdgeJSON contains a set of useful extensions for [String: Any] type in Swift.
Using the JSON static functions, you can handle all errors in one place: the `errorHandler`.
By doing this, your code does not have to be riddled with `do-catch`s and `try`s.
                       DESC

  s.homepage         = 'https://github.com/<GITHUB_USERNAME>/EdgeJSON'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Joshua Park' => 'joshuaparkwm@gmail.com' }
  s.source           = { :git => 'https://github.com/<GITHUB_USERNAME>/EdgeJSON.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'EdgeJSON/Classes/**/*'
  
  # s.resource_bundles = {
  #   'EdgeJSON' => ['EdgeJSON/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
