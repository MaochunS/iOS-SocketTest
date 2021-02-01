//
//  UIRoundedButtonWithGradientAndShadow.swift
//  FlipRAS
//
//  Created by Maochun Sun on 2019/9/1.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import UIKit

class GradientButton: UIButton {
    
    let gradientColors : [UIColor]
    let disabledGradientColors = [UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1),
                                  UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)]
    let startPoint : CGPoint
    let endPoint : CGPoint
    let hasShadow = false
    let highlightColor = UIColor(red: 0x01/0xFF, green: 0x11/0xFF, blue: 0x1C/0xFF, alpha: 1)
    
    required init(gradientColors: [UIColor],
                  startPoint: CGPoint = CGPoint(x: 0, y: 0.5),
                  endPoint: CGPoint = CGPoint(x: 1, y: 0.5)) {
        self.gradientColors = gradientColors
        self.startPoint = startPoint
        self.endPoint = endPoint
        
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let halfOfButtonHeight = layer.frame.height / 2
        contentEdgeInsets = UIEdgeInsets(top: 10, left: halfOfButtonHeight, bottom: 10, right: halfOfButtonHeight)
        
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        backgroundColor = UIColor.clear
        
        // setup gradient
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        
        if self.isEnabled{
            gradient.colors = gradientColors.map { $0.cgColor }
            
        }else{
            gradient.colors = disabledGradientColors.map { $0.cgColor }
        }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.cornerRadius = 10 //halfOfButtonHeight
        
        // replace gradient as needed
        if let oldGradient = layer.sublayers?[0] as? CAGradientLayer {
            layer.replaceSublayer(oldGradient, with: gradient)
        } else {
            layer.insertSublayer(gradient, below: nil)
        }
        
        // setup shadow
        if hasShadow{
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: halfOfButtonHeight).cgPath
            layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            layer.shadowOpacity = 0.3
            layer.shadowRadius = 2.0
        }
    }
    
    /*
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            self.clipsToBounds = true  
            self.setBackgroundImage(colorImage, for: state)
        }
    }
    */
    
    override var isEnabled: Bool{
        didSet{
            if isEnabled{
                let gradient: CAGradientLayer = CAGradientLayer()
                gradient.frame = self.bounds
                gradient.colors = gradientColors.map { $0.cgColor }
                gradient.startPoint = startPoint
                gradient.endPoint = endPoint
                gradient.cornerRadius = 10
                
                if let oldGradient = layer.sublayers?[0] as? CAGradientLayer {
                    layer.replaceSublayer(oldGradient, with: gradient)
                }
                
            }else{
                let gradient: CAGradientLayer = CAGradientLayer()
                gradient.frame = self.bounds
                gradient.colors = [UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)]
                gradient.startPoint = startPoint
                gradient.endPoint = endPoint
                gradient.cornerRadius = 10
                if let oldGradient = layer.sublayers?[0] as? CAGradientLayer {
                    layer.replaceSublayer(oldGradient, with: gradient)
                }
               
            }
        }
    }
    
    
    override var isHighlighted: Bool {
        didSet {
            
            /*
            let newOpacity : Float = isHighlighted ? 0.6 : 0.85
            let newRadius : CGFloat = isHighlighted ? 6.0 : 4.0
            
            if hasShadow{
                let shadowOpacityAnimation = CABasicAnimation()
                shadowOpacityAnimation.keyPath = "shadowOpacity"
                shadowOpacityAnimation.fromValue = layer.shadowOpacity
                shadowOpacityAnimation.toValue = newOpacity
                shadowOpacityAnimation.duration = 0.1
                
                let shadowRadiusAnimation = CABasicAnimation()
                shadowRadiusAnimation.keyPath = "shadowRadius"
                shadowRadiusAnimation.fromValue = layer.shadowRadius
                shadowRadiusAnimation.toValue = newRadius
                shadowRadiusAnimation.duration = 0.1
                
                layer.add(shadowOpacityAnimation, forKey: "shadowOpacity")
                layer.add(shadowRadiusAnimation, forKey: "shadowRadius")
                
                layer.shadowOpacity = newOpacity
            }
            layer.shadowRadius = newRadius
            
            let xScale : CGFloat = isHighlighted ? 1.1 : 1.0 //1.025 : 1.0
            let yScale : CGFloat = isHighlighted ? 1.1 : 1.0//1.05 : 1.0
            UIView.animate(withDuration: 0.1) {
                let transformation = CGAffineTransform(scaleX: xScale, y: yScale)
                self.transform = transformation
            }
            */
            
            rippleEffect()
        }
    }
    
    
    func rippleEffect(){
        let scaleFactor : CGFloat = 1.0
        let animationColor : UIColor = self.highlightColor
        let animationDuration : Double = 0.3


        let coverView = UIView(frame: self.bounds)

        coverView.layer.cornerRadius = 10
        //coverView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        coverView.clipsToBounds = true
        coverView.backgroundColor = UIColor.clear
        self.addSubview(coverView)

        //let touch = touches.first!
        let point = CGPoint(x: self.frame.width/2, y: self.frame.height/2)

        let ourTouchView = UIView(frame: CGRect(x: point.x - 5, y: point.y - 5, width: 10, height: 10))
        //print(ourTouchView)
        //print(point)


        let circleMaskPathInitial = UIBezierPath(ovalIn: ourTouchView.frame)
        let radius = max((self.bounds.width * scaleFactor) , (self.bounds.height * scaleFactor))
        let circleMaskPathFinal = UIBezierPath(ovalIn: ourTouchView.frame.insetBy(dx: -radius, dy: -radius))


        let rippleLayer = CAShapeLayer()
        rippleLayer.opacity = 0.4
        rippleLayer.fillColor = animationColor.cgColor
        //rippleLayer.path = circleMaskPathFinal.cgPath

        rippleLayer.path = UIBezierPath(rect: self.bounds).cgPath
        //rippleLayer.masksToBounds = true
        coverView.layer.addSublayer(rippleLayer)

        //fade up
        let fadeUp = CABasicAnimation(keyPath: "opacity")
        fadeUp.beginTime = CACurrentMediaTime()
        fadeUp.duration = animationDuration * 0.6
        fadeUp.toValue = 0.6
        fadeUp.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fadeUp.fillMode = CAMediaTimingFillMode.forwards
        fadeUp.isRemovedOnCompletion = false
        rippleLayer.add(fadeUp, forKey: nil)

        //fade down
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.beginTime = CACurrentMediaTime() + animationDuration * 0.60
        fade.duration = animationDuration * 0.40
        fade.toValue = 0
        fade.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fade.fillMode = CAMediaTimingFillMode.forwards
        fade.isRemovedOnCompletion = false
        rippleLayer.add(fade, forKey: nil)

        //change path
        CATransaction.begin()
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.cgPath
        maskLayerAnimation.toValue = circleMaskPathFinal.cgPath
        maskLayerAnimation.beginTime = CACurrentMediaTime()
        maskLayerAnimation.duration = animationDuration
        maskLayerAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        CATransaction.setCompletionBlock({
         
            coverView.removeFromSuperview()
         
        })
        rippleLayer.add(maskLayerAnimation, forKey: "path")
        CATransaction.commit()
    }
}
