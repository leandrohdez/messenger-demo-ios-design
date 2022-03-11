# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Messenger' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Messenger
  pod 'GoogleMLKit/SmartReply', '2.6.0'
  
  pod "PromiseKit", "~> 6.8"

end

post_install do |installer|
  
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
 
end
