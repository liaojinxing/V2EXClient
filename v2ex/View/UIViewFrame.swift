//
//  UIViewFrame.swift
//  v2ex
//
//  Created by liaojinxing on 14/10/17.
//  Copyright (c) 2014年 jinxing. All rights reserved.
//

import Foundation

extension UIView {
    
    func setFrameHeight(height: CGFloat) {
        var frame = self.frame
        frame.size.height = height
        self.frame = frame
    }
    
    func setFrameWidth(width: CGFloat) {
        var frame = self.frame
        frame.size.width = width
        self.frame = frame
    }
    
    func setFrameOriginX(originX: CGFloat) {
        var frame = self.frame
        frame.origin.x = originX
        self.frame = frame
    }
    
    func setFrameOriginY(originY: CGFloat) {
        var frame = self.frame
        frame.origin.y = originY
        self.frame = frame
    }
}
