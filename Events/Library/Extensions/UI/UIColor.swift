//
//  UIColor.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/22/21.
//

import UIKit

extension UIColor {

    convenience init(r: UInt8, g: UInt8, b: UInt8, alpha: CGFloat = 1.0) {
        let divider: CGFloat = 255.0
        self.init(red: CGFloat(r)/divider, green: CGFloat(g)/divider, blue: CGFloat(b)/divider, alpha: alpha)
    }
}
