//
//  NVActivityIndicatorViewWrapperView.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/14.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class NVActivityIndicatorViewWrapperView: UIView {
    private let view: NVActivityIndicatorView
    
    
    init(intrinsicSize: CGSize,
         type: NVActivityIndicatorType? = nil,
         color: UIColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0),
         padding: CGFloat? = nil) {
        view = NVActivityIndicatorView(frame: .zero, type: type, color: color, padding: padding)
        
        super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: intrinsicSize))
        addSubview(view)
        view.frame = bounds
        translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        view.startAnimating()
    }
    
    deinit {
        view.stopAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return bounds.size
    }
}
