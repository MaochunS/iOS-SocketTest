//
//  UIView+Extension.swift
//  APPCommon
//
//  Created by maochun on 2020/7/23.
//  Copyright © 2020 maochun. All rights reserved.
//

import UIKit

extension UIView {
    func shake1() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    
    func shake(count : Float = 4,for duration : TimeInterval = 0.3,withTranslation translation : Float = 3) {

        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
    
    
    func pulse() {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")

        animation.values = [1.0, 1.2, 1.0]
        animation.keyTimes = [0, 0.5, 1]
        animation.duration = 1.5
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: nil)
    }
}
