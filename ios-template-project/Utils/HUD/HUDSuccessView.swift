//
//  HUDSuccessView.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/14.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit

public class HUDSuccessView: UIView, HUDAnimating {
    
    var checkmarkShapeLayer: CAShapeLayer = {
        let checkmarkPath = UIBezierPath()
        checkmarkPath.move(to: CGPoint(x: 4.0, y: 27.0))
        checkmarkPath.addLine(to: CGPoint(x: 34.0, y: 56.0))
        checkmarkPath.addLine(to: CGPoint(x: 88.0, y: 0.0))
        
        let layer = CAShapeLayer()
        layer.frame = CGRect(x: 3.0, y: 3.0, width: 88.0, height: 56.0)
        layer.path = checkmarkPath.cgPath
        
        #if swift(>=4.2)
        layer.fillMode    = .forwards
        layer.lineCap     = .round
        layer.lineJoin    = .round
        #else
        layer.fillMode    = kCAFillModeForwards
        layer.lineCap     = kCALineCapRound
        layer.lineJoin    = kCALineJoinRound
        #endif
        
        layer.fillColor   = nil
        layer.strokeColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0).cgColor
        layer.lineWidth   = 6.0
        return layer
    }()
    
    public init(intrinsicSize: CGSize) {
        super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: intrinsicSize))
        layer.addSublayer(checkmarkShapeLayer)
        checkmarkShapeLayer.position = layer.position
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.addSublayer(checkmarkShapeLayer)
        checkmarkShapeLayer.position = layer.position
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        startAnimation()
    }
    
    
    deinit {
        stopAnimation()
    }
    
    func startAnimation() {
        let checkmarkStrokeAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
        checkmarkStrokeAnimation.values = [0, 1]
        checkmarkStrokeAnimation.keyTimes = [0, 1]
        checkmarkStrokeAnimation.duration = 0.35
        checkmarkShapeLayer.add(checkmarkStrokeAnimation, forKey: "checkmarkStrokeAnim")
    }
    
    func stopAnimation() {
        checkmarkShapeLayer.removeAnimation(forKey: "checkmarkStrokeAnimation")
    }
    
    public override var intrinsicContentSize: CGSize {
        return bounds.size
    }
}
