//
//  ViewController.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/19.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DZNEmptyDataSet

class ViewController: UIViewController, Navigatable {
    var navigator: Navigator!
    
    let isLoading = BehaviorRelay(value: false)
    
    var automaticallyAdjustsLeftBarButtonItem = true
    
    var navigationTitle = "" {
        didSet {
            navigationItem.title = navigationTitle
        }
    }
    
    var emptyDataSetTitle = R.string.localizable.commonNoContent.key.localized()
    var emptyDataSetImage = R.image.empty_content()
    var emptyDataSetImageTintColor = BehaviorRelay<UIColor?>(value: nil)
    
    lazy var closeBarButton: BarButtonItem = {
        let view = BarButtonItem(image: R.image.cancel(),
                                 style: .plain,
                                 target: self,
                                 action: nil)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        bindViewModel()
        
        closeBarButton.rx.tap.asObservable().subscribe(onNext: { [weak self] () in
            self?.navigator.dismiss(sender: self)
        }).disposed(by: rx.disposeBag)
        
        // Observe device orientation change
        NotificationCenter.default
            .rx.notification(UIDevice.orientationDidChangeNotification)
            .subscribe { [weak self] (_) in
                self?.orientationChanged()
            }.disposed(by: rx.disposeBag)
        
        // Observe application did become active notification
        NotificationCenter.default
            .rx.notification(UIApplication.didBecomeActiveNotification)
            .subscribe { [weak self] (_) in
                self?.didBecomeActive()
            }.disposed(by: rx.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if automaticallyAdjustsLeftBarButtonItem {
            adjustLeftBarButtonItem()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func makeUI() {
        view.backgroundColor = .white
    }
    
    func bindViewModel() {
        
    }
    
    func updateUI() {
        
    }
    
    func orientationChanged() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.updateUI()
        }
    }
    
    func didBecomeActive() {
        self.updateUI()
    }
    
    func adjustLeftBarButtonItem() {
        if navigationController?.viewControllers.count ?? 0 > 1 { // Pushed
            navigationItem.leftBarButtonItem = nil
        } else if presentingViewController != nil { // presented
            navigationItem.leftBarButtonItem = closeBarButton
        }
    }
    
    func currentViewController() -> String {
        guard let `class` = "\(self)".split(separator: ".").last else {
            return "unknow viewcontroller class"
        }
        return String(`class`)
    }
}

extension ViewController {
    var inset: CGFloat {
        return 10
    }
    
    func emptyView(height: CGFloat) -> View {
        let view = View()
        view.snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
        return view
    }
}

extension Reactive where Base: ViewController {
    var emptyDataSetImageTintColorBinder: Binder<UIColor?> {
        return Binder(base) { view, color in
            view.emptyDataSetImageTintColor.accept(color)
        }
    }
}

extension ViewController: DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: emptyDataSetTitle)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return emptyDataSetImage
    }
    
    func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return emptyDataSetImageTintColor.value
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return .clear
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -60
    }
}

extension ViewController: DZNEmptyDataSetDelegate {
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return !isLoading.value
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}
