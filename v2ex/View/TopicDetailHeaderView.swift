//
//  TopicDetailHeaderView.swift
//  v2ex
//
//  Created by liaojinxing on 14/10/17.
//  Copyright (c) 2014年 jinxing. All rights reserved.
//

import UIKit

class TopicDetailHeaderView: UIView {

    @IBOutlet var titleLabel: UILabel! = nil
    @IBOutlet var detailLabel: UILabel! = nil
    
    var title: String? {
        didSet {
            self.titleLabel.text = title?
        }
    }

    var content: String? {
        didSet {
            self.detailLabel.text = content?
            self.setNeedsLayout()
            self.layoutIfNeeded()
            self.setFrameHeight(CGRectGetMaxY(self.detailLabel.frame)*1.2)
        }
    }
    
}
