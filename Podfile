# Uncomment the next line to define a global platform for your project
platform :ios, '10.3'

def test_pods
  pod 'Quick'
  pod 'Nimble'
end

target 'ios-template-project' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  #ReactiveX
  pod 'RxCocoa'
  pod 'RxViewController'
  pod 'RxDataSources'
  pod 'RxSwiftExt'
  pod 'Action'
  pod 'NSObject+Rx'

  # Networking
  pod 'Alamofire'
  pod 'Moya/RxSwift'
  pod 'ReachabilitySwift'
  # pod 'RxStarscream'
  # pod 'Starscream'
  
  # Image
  pod 'SDWebImage'
  
  # Date
  pod 'SwiftDate'
  
  # Keyboard
  pod 'IQKeyboardManagerSwift'
  
  # Auto Layout
  pod 'SnapKit'

  # UI
  pod 'Hero'
  pod 'UITextView+Placeholder'
  pod 'MJRefresh'
  pod 'RxMJ'
  pod 'MBProgressHUD'
  pod 'FSPagerView'
  pod 'DZNEmptyDataSet'
  pod 'Localize-Swift'
  # pod 'Texture'
  # pod 'MGSwipeTableCell'

  # Storage
  pod 'KeychainAccess'
  pod 'Cache'
  
  # Logging
  pod 'CocoaLumberjack/Swift'

  # utils
  pod 'Device'
  pod 'UIFontComplete'
  pod 'SwifterSwift'
  
  # Tools
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
