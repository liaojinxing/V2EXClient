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
    var headerView : TopicDetailHeaderView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nibViews = NSBundle.mainBundle().loadNibNamed("TopicDetailHeaderView", owner: self, options: nil)
        self.headerView = nibViews.first as? TopicDetailHeaderView
        self.headerView?.title = json["title"].stringValue
        self.headerView?.avatarURL = "http:" + json["member"]["avatar_large"].stringValue
        self.headerView?.author = json["member"]["username"].stringValue
        self.headerView?.content = json["content"].stringValue
        self.headerView?.setFrameHeight(1000)
        self.tableView.tableHeaderView = self.headerView
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.registerNib(UINib(nibName: "ReplyCell", bundle: nil), forCellReuseIdentifier: "ReplyCell")
        self.sendRequest()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.headerView?.setFrameHeight(CGRectGetMaxY((self.headerView?.detailLabel.frame)!) + 30)
        self.tableView.tableHeaderView = self.headerView
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
        if (self.datasource != nil && self.datasource.count != 0) {
            return "讨论区"
        } else {
            return "暂无讨论"
        }
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
