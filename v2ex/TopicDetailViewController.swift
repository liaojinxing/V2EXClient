//
//  TopicDetailViewController.swift
//  v2ex
//
//  Created by liaojinxing on 14/10/17.
//  Copyright (c) 2014年 jinxing. All rights reserved.
//

import UIKit

class TopicDetailViewController: BaseTableViewController {
    
    var json : JSON!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nibViews = NSBundle.mainBundle().loadNibNamed("TopicDetailHeaderView", owner: self, options: nil)
        var headerView = nibViews.first as? TopicDetailHeaderView
        headerView?.title = json["title"].stringValue
        headerView?.content = json["content"].stringValue
        self.tableView.tableHeaderView = headerView
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "")
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func onPullToFresh() {
        self.refreshing = false
    }
}
