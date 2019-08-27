//
//  HomeTabBarController.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/21.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit
import RxViewController

extension TabbarItem {
    var title: String {
        switch self {
        case .sample:
            return "sample"
        case .profile:
            return "profile"
        }
    }
    
    var image: UIImage? {
        return nil
    }
    
    var selectedImage: UIImage? {
        return nil
    }
    
    private func getViewController(with viewModel: ViewModel) -> UIViewController {
        switch self {
        case .sample:
            let vc = SampleViewController()
            vc.viewModel = viewModel as? SampleViewModel
            return NavigationController(rootViewController: vc)
        case .profile:
            let vc = ProfileViewController()
            vc.viewModel = viewModel as? ProfileViewModel
            return NavigationController(rootViewController: vc)
        }
    }
    
     func viewController(for viewModel: ViewModel) -> UIViewController {
        let vc = getViewController(with: viewModel)
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        vc.tabBarItem = tabBarItem
        return vc
    }
}

class HomeTabBarController: UITabBarController, Navigatable {
    var navigator: Navigator!
    var viewModel: HomeTabBarViewModel
    
    init(navigator: Navigator, viewModel: HomeTabBarViewModel) {
        self.navigator = navigator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeupUI()
        bindViewModel()
    }
    
    func makeupUI() {
        view.backgroundColor = .white
    }

    func bindViewModel() {
        let input = HomeTabBarViewModel.Input(viewDidAppear: rx.viewDidAppear.mapTo(()))
        let out = viewModel.transform(input: input)
        out.tabBarItems.drive(onNext: { [weak self] (items) in
            guard let self = self else { return }
            let controllers = items.map {
                $0.viewController(for: self.viewModel.viewModel(for: $0))
            }
            self.setViewControllers(controllers, animated: false)
            self.navigator.injectTabBarController(in: self)
        }).disposed(by: rx.disposeBag)
    }
}
