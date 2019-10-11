platform :ios, '10.3'
install! 'cocoapods', 
          :generate_multiple_pod_projects => true, 
          :incremental_installation => true,
          :deduplicate_targets => true

def test_pods
  pod 'Quick'
  pod 'Nimble'
end

target 'ios-template-project' do
  use_frameworks!
  inhibit_all_warnings!

  #ReactiveX
  pod 'RxCocoa'
  pod 'RxViewController'
  pod 'RxDataSources'
  pod 'RxSwiftExt'
  pod 'NSObject+Rx'

  # Networking
  pod 'Alamofire'
  pod 'Moya/RxSwift'
  pod 'ReachabilitySwift'
  pod 'SDWebImage'

  # UI
  pod 'UITextView+Placeholder'
  pod 'MJRefresh'
  pod 'RxMJ'
  pod 'MBProgressHUD'
  pod 'FSPagerView'
  pod 'DZNEmptyDataSet'
  pod 'Localize-Swift'

  # Storage
  pod 'KeychainAccess'
  pod 'Cache'
  
  # Logging
  pod 'CocoaLumberjack/Swift'

  # utils
  pod 'IQKeyboardManagerSwift'
  pod 'SnapKit'
  pod 'Device'
  pod 'UIFontComplete'
  pod 'SwifterSwift'
  pod 'R.swift'
  pod 'SwiftLint'
  pod 'Bugly'

  # Pods for ios-template-project

  target 'ios-template-projectTests' do
    inherit! :search_paths
    # Pods for testing
    test_pods
  end

  target 'ios-template-projectUITests' do
    inherit! :search_paths
    # Pods for testing
    test_pods
  end

end
