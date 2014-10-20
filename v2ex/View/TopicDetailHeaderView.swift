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
    
    override func awakeFromNib() {
        self.titleLabel.font = UIFont.boldSystemFontOfSize(19)
        self.detailLabel.font = UIFont.systemFontOfSize(17)
    }
    
    var title: String? {
        didSet {
            self.titleLabel.text = title?
            print(title)
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }

    var content: String? {
        didSet {
            self.detailLabel.text = content?
            self.titleLabel.text = self.title
            self.setNeedsLayout()
            self.layoutIfNeeded()
            self.setFrameHeight(CGRectGetMaxY(self.detailLabel.frame) + 20)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.preferredMaxLayoutWidth = self.titleLabel.frame.size.width
        self.detailLabel.preferredMaxLayoutWidth = self.detailLabel.frame.size.width
    }

}
