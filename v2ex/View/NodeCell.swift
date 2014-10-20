//
//  NodeCell.swift
//  v2ex
//
//  Created by liaojinxing on 14/10/20.
//  Copyright (c) 2014年 jinxing. All rights reserved.
//

import UIKit

class NodeCell: UICollectionViewCell {
    
    var nameLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.nameLabel = UILabel(frame: self.contentView.bounds)
        self.nameLabel?.textAlignment = .Center
        self.contentView.addSubview(self.nameLabel!)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
