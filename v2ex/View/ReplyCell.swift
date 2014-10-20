//
//  ReplyCell.swift
//  v2ex
//
//  Created by liaojinxing on 14/10/20.
//  Copyright (c) 2014年 jinxing. All rights reserved.
//

import UIKit

class ReplyCell: UITableViewCell {
    
    @IBOutlet var avatarImageView: UIImageView! = nil
    @IBOutlet var contentLabel: UILabel! = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutSubviews()
        self.contentLabel.preferredMaxLayoutWidth = self.contentLabel.frame.size.width
    }
    
    func update(json: JSON) {
        var avatarURL = "http:" + json["member"]["avatar_large"].stringValue
        self.avatarImageView.sd_setImageWithURL(NSURL(string: avatarURL), placeholderImage: UIImage(named: "avatar_normal"))
        self.contentLabel.text = json["content"].stringValue
    }

}
