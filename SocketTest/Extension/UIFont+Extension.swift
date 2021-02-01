//
//  UIFont+Extension.swift
//  StreamMerchant
//
//  Created by maochun on 2020/12/23.
//

import UIKit

extension UIFont{
    
    private static func customFont(name: String, size: CGFloat) -> UIFont {
            let font = UIFont(name: name, size: size)
            assert(font != nil, "Can't load font: \(name)")
            return font ?? UIFont.systemFont(ofSize: size)
        }
        
    static func titleFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Arial", size: size)
    }
    
    static func buttonFont(ofSize size: CGFloat = 18) -> UIFont{
        return customFont(name: "Arial", size: size)
    }
    
    static func statusFont(ofSize size: CGFloat = 18) -> UIFont{
        return customFont(name: "Arial", size: size)
    }
}
