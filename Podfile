# Uncomment the next line to define a global platform for your project
#   Disable Code Coverage for Pods projects
post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
    end
  end
end

platform :ios, '9.0'

target 'LandmarkRemark' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for LandmarkRemark
  
  # Firebase
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  
  target 'LandmarkRemarkTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  target 'LandmarkRemarkUITests' do
    # Pods for testing
  end
  
end
