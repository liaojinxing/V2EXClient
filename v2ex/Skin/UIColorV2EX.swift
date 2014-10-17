//
//  UIColorV2EX.swift
//  v2ex
//
//  Created by liaojinxing on 14/10/17.
//  Copyright (c) 2014年 jinxing. All rights reserved.
//

import Foundation

extension UIColor {
    
    class func V2EXColor() -> UIColor {
        return UIColor.colorWithHex(0x525252)
    }
    
    class func colorWithHex(rgbHexValue:NSInteger) -> UIColor{
        let red = CGFloat((rgbHexValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbHexValue & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(rgbHexValue & 0xFF) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}
