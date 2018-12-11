//
//  UIImageView+Ex.swift
//  Extensions
//
//  Created by liubo on 2018/8/28.
//

import UIKit

extension Extensible where Base: UIImageView {
    public func download(from url: URL,
                         contentMode: UIView.ContentMode = .scaleAspectFill,
                         placeHolder: UIImage? = nil,
                         completionHandler: ((UIImage?) -> Void)? = nil) {
        base.image = placeHolder
        base.contentMode = contentMode
        URLSession.shared.dataTask(with: url) { (data, response, _) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data,
                let image = UIImage(data: data)
                else {
                    completionHandler?(nil)
                    return
            }
            DispatchQueue.main.async {
                self.base.image = image
                completionHandler?(image)
            }
        }.resume()
    }
    
    public func blur(with style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = base.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        base.addSubview(blurEffectView)
        base.clipsToBounds = true
    }
    
    public func blurred(with style: UIBlurEffect.Style = .light) -> UIImageView {
        let imageView = base
        imageView.ext.blur(with: style)
        return imageView
    }
}
