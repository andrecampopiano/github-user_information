
 platform :ios, '11.0'
 use_frameworks!
 inhibit_all_warnings!
 
 load 'PodfileSupport.rb'

# Pods
def external_libs
  pod 'SwiftLint'
end

def module_common
    
end

def module_pods
  module_common
#  setup(mod:'CoreSwift', path:"/core-swift", branch: 'main', local: true)
end

def test_libs
  pod 'iOSSnapshotTestCase'
  module_common
end

target 'GitHubUserInformation' do
  
  module_pods
  external_libs

  target 'GitHubUserInformationTests' do
    test_libs
  end

  target 'GitHubUserInformationUITests' do
    test_libs
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
