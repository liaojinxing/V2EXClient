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
    @IBOutlet var avatarImageView: UIImageView! = nil
    @IBOutlet var authorLabel: UILabel! = nil
    
    
    override func awakeFromNib() {
        self.titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.detailLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.avatarImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.authorLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
    }
    
    var title: String? {
        didSet {
            self.titleLabel.text = title?
        }
    }
    
    var avatarURL: String? {
        didSet {
            self.avatarImageView.sd_setImageWithURL(NSURL(string: avatarURL!), placeholderImage: UIImage(named: "avatar_normal"))
        }
    }

    var author: String? {
        didSet {
            self.authorLabel.text = author?
        }
    }
    
    var content: String? {
        didSet {
            self.detailLabel.text = content?
            self.titleLabel.text = self.title
            self.setNeedsUpdateConstraints()
            self.updateConstraintsIfNeeded()
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.preferredMaxLayoutWidth = self.titleLabel.bounds.size.width
        self.detailLabel.preferredMaxLayoutWidth = self.detailLabel.bounds.size.width
        self.authorLabel.preferredMaxLayoutWidth = self.authorLabel.bounds.size.width
        self.setFrameHeight(CGRectGetMaxY(self.detailLabel.frame) + 36)
    }
}
