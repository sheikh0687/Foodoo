# Uncomment the next line to define a global platform for your project
# platform :ios, '12.0'

target 'Foodoo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for Foodoo
  
  pod 'R.swift', '~> 5.4.0'
  pod 'SlideMenuControllerSwift'
  
  pod 'Alamofire', '~> 4.9.1'
  pod 'SDWebImage/WebP'
  
  pod 'SkeletonView'
  
  pod 'CountryPickerView'
  pod 'IQKeyboardManagerSwift'
  
  pod 'InputMask'
  pod 'SwiftyJSON'
  pod 'Cosmos'
  
  pod 'DropDown'
  
  pod 'LanguageManager-iOS'
  
  #  pod 'GoogleSignIn', '~> 7.1.0'
  #  pod 'GoogleSignIn', '~> 5.0.2'
  
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    # Fix libarclite_xxx.a file not found.
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end

#post_install do |installer_representation|
#  installer_representation.pods_project.targets.each do |target|
#    target.build_configurations.each do |config|
#      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
#      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
#      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
#    end
#  end
#end
