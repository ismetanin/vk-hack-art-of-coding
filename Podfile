platform :ios, '11.0'

inhibit_all_warnings!

target 'sevcabel' do
  use_frameworks!

  pod 'Mapbox-iOS-SDK'
	pod 'VK-ios-sdk'
	pod 'SwiftyVK'
	pod 'Nuke'
    
    pod 'Firebase/Core'
    pod 'Firebase/Database'
    pod 'CodableFirebase'
    
    pod 'ARCL'

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
