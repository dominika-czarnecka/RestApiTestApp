source 'https://github.com/CocoaPods/Specs.git'

platform :ios, "9.0"

inhibit_all_warnings!
use_frameworks!

def import_common_pods
	
	pod 'KVNProgress'
	pod 'RxSwift'
	pod 'RxCocoa'
	pod 'RxDataSources'
	pod 'KeychainAccess'
    
end

target 'FibaroRecruitmentApp' do
  import_common_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
