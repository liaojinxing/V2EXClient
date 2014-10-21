//
//  TopicCell.swift
//  v2ex
//
//  Created by liaojinxing on 14-10-16.
//  Copyright (c) 2014年 jinxing. All rights reserved.
//

import UIKit

let TopicCellID = "TopicCellID"


class TopicCell: UITableViewCell {
    
    @IBOutlet var titleLabel : UILabel! = nil
    @IBOutlet var avatarImageView : UIImageView! = nil
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        avatarImageView = UIImageView(frame:CGRectMake(15, 15, 30, 30))
        self.contentView.addSubview(avatarImageView)
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        titleLabel = UILabel(frame: CGRectMake(60, 10, screenWidth - 70, self.frame.size.height))
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.boldSystemFontOfSize(17)
        self.contentView.addSubview(titleLabel)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
