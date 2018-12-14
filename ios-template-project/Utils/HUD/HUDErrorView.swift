//
//  HUDErrorView.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/14.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit

public class HUDErrorView: UIView, HUDAnimating {
    
    var dashOneLayer = HUDErrorView.generateDashLayer()
    var dashTwoLayer = HUDErrorView.generateDashLayer()
    
    class func generateDashLayer() -> CAShapeLayer {
        let dash = CAShapeLayer()
        dash.frame = CGRect(x: 0.0, y: 0.0, width: 88.0, height: 88.0)
        dash.path = {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0.0, y: 44.0))
            path.addLine(to: CGPoint(x: 88.0, y: 44.0))
            return path.cgPath
        }()
        
        #if swift(>=4.2)
        dash.lineCap     = .round
        dash.lineJoin    = .round
        dash.fillMode    = .forwards
        #else
        dash.lineCap     = kCALineCapRound
        dash.lineJoin    = kCALineJoinRound
        dash.fillMode    = kCAFillModeForwards
        #endif
        
        dash.fillColor   = nil
        dash.strokeColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0).cgColor
        dash.lineWidth   = 6
        return dash
    }
    
    public init(intrinsicSize: CGSize) {
        super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: intrinsicSize))
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.addSublayer(dashOneLayer)
        layer.addSublayer(dashTwoLayer)
        dashOneLayer.position = layer.position
        dashTwoLayer.position = layer.position
    }
    
    func rotationAnimation(_ angle: CGFloat) -> CABasicAnimation {
        var animation: CABasicAnimation
        if #available(iOS 9.0, *) {
            let springAnimation = CASpringAnimation(keyPath: "transform.rotation.z")
            springAnimation.damping = 1.5
            springAnimation.mass = 0.22
            springAnimation.initialVelocity = 0.5
            animation = springAnimation
        } else {
            animation = CABasicAnimation(keyPath: "transform.rotation.z")
        }
        
        animation.fromValue = 0.0
        animation.toValue = angle * CGFloat(.pi / 180.0)
        animation.duration = 1.0
        
        #if swift(>=4.2)
        let timingFunctionName = CAMediaTimingFunctionName.easeInEaseOut
        #else
        let timingFunctionName = kCAMediaTimingFunctionEaseInEaseOut
        #endif
        
        animation.timingFunction = CAMediaTimingFunction(name: timingFunctionName)
        return animation
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        startAnimation()
    }
    
    public override var intrinsicContentSize: CGSize {
        return bounds.size
    }
    
    deinit {
        stopAnimation()
    }
    
    func startAnimation() {
        let dashOneAnimation = rotationAnimation(-45.0)
        let dashTwoAnimation = rotationAnimation(45.0)
        
        dashOneLayer.transform = CATransform3DMakeRotation(-45 * CGFloat(.pi / 180.0), 0.0, 0.0, 1.0)
        dashTwoLayer.transform = CATransform3DMakeRotation(45 * CGFloat(.pi / 180.0), 0.0, 0.0, 1.0)
        
        dashOneLayer.add(dashOneAnimation, forKey: "dashOneAnimation")
        dashTwoLayer.add(dashTwoAnimation, forKey: "dashTwoAnimation")
    }
    
    func stopAnimation() {
        dashOneLayer.removeAnimation(forKey: "dashOneAnimation")
        dashTwoLayer.removeAnimation(forKey: "dashTwoAnimation")
    }
}
