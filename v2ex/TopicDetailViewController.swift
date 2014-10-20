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
    var referenceCell: ReplyCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nibViews = NSBundle.mainBundle().loadNibNamed("TopicDetailHeaderView", owner: self, options: nil)
        var headerView = nibViews.first as? TopicDetailHeaderView
        headerView?.title = json["title"].stringValue
        headerView?.content = json["content"].stringValue
        self.tableView.tableHeaderView = headerView
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.registerNib(UINib(nibName: "ReplyCell", bundle: nil), forCellReuseIdentifier: "ReplyCell")
        self.sendRequest()
    }
    
    func sendRequest() {
        self.refreshing = true
        APIClient.sharedInstance.getReplies(self.json["id"].stringValue, success: { (json) -> Void in
            self.refreshing = false
            if json.type == Type.Array {
                self.datasource = json.arrayValue
            }
        }) { (error) -> Void in
            self.refreshing = false
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.datasource != nil) {
            return self.datasource.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40;
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "讨论区";
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (self.referenceCell? == nil) {
            self.referenceCell = tableView.dequeueReusableCellWithIdentifier("ReplyCell") as? ReplyCell
        }
        let json = self.datasource[indexPath.row] as JSON
        self.referenceCell?.update(json)
        self.referenceCell?.setNeedsLayout()
        self.referenceCell?.layoutIfNeeded()
        var height = max(CGRectGetMaxY((self.referenceCell?.contentLabel.frame)!), CGRectGetMaxY((self.referenceCell?.avatarImageView.frame)!)) + 8
        return height
    }
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ReplyCell") as? ReplyCell
        let json = self.datasource[indexPath.row] as JSON
        cell?.update(json)
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func onPullToFresh() {
        self.sendRequest()
    }
}
