//
//  UIColor+Extension.swift
//  StreamMerchant
//
//  Created by maochun on 2020/12/23.
//

import UIKit

extension UIColor{
    convenience init(rgbValue: Int, alpha: CGFloat = 1.0) {
            let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

            self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

        
    func toImage(width: CGFloat = 2, height: CGFloat = 2) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)

        defer { UIGraphicsEndImageContext() }

        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(self.cgColor)
            context.fill(rect)
        }

        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
    
    static func titleColor() -> UIColor{
     
        return UIColor(rgbValue: 0x1F2020)
    }
    
    static func commonVCBkColor() ->UIColor{
        return UIColor(rgbValue: 0xF7F7F7)
    }
    
    static func commonButtonColor() -> UIColor{
        return UIColor(rgbValue: 0xEE0000)
    }
}
