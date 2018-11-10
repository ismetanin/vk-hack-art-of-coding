# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

inhibit_all_warnings!

target 'sevcabel' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

	pod 'VK-ios-sdk'
	pod 'SwiftyVK'
	pod 'Nuke'

  target 'sevcabelTests' do
    inherit! :search_paths
    # Pods for testing
  end

	post_install do |installer|
	  installer.pods_project.targets.each do |target|
	      if ['SwiftyVK'].include? target.name
	          target.build_configurations.each do |config|
	              config.build_settings['SWIFT_VERSION'] = '4.0'
	          end
	      end
	  end
	end

end
