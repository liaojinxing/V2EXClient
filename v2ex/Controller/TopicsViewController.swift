//
//  ViewController.swift
//  v2ex
//
//  Created by liaojinxing on 14-10-16.
//  Copyright (c) 2014年 jinxing. All rights reserved.
//

import UIKit

class TopicsViewController: BaseTableViewController {
    
    var imageView: UIImageView!
    var nodeJSON: JSON? // Node

    override func viewDidLoad() {
        super.viewDidLoad()
        if let node = self.nodeJSON? {
            self.title = node["title"].stringValue
        } else {
            self.title = "V2EX最热"
        }
        if nodeJSON == nil {
            let rightItem = UIBarButtonItem(image: UIImage(named: "nodes"), style: UIBarButtonItemStyle.Plain, target: self, action: "selectNode")
            self.navigationItem.rightBarButtonItem = rightItem
        }
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.refreshing = true
        self.sendRequest()
    }
    
    func selectNode() {
        let vc = NodesViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func sendRequest() {
        if let node = self.nodeJSON? {
            self.refreshing = true
            APIClient.sharedInstance.getLatestTopics(node["id"].stringValue, success: { (json) -> Void in
                self.refreshing = false
                if json.type == Type.Array {
                    self.datasource = json.arrayValue
                }
            }, failure: { (error) -> Void in
                self.refreshing = false
            })
        } else {
            self.refreshing = true
            APIClient.sharedInstance.getLatestTopics({ (json) -> Void in
                    self.refreshing = false
                    if json.type == Type.Array {
                        self.datasource = json.arrayValue
                    }
                }, failure: { (error) -> Void in
                    self.refreshing = false
            })
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.datasource != nil) {
            return self.datasource.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(TopicCellID) as? TopicCell
        
        if cell == nil {
            cell = TopicCell(style: .Default, reuseIdentifier: TopicCellID)
        }

        let json = self.datasource[indexPath.row] as JSON
        cell?.titleLabel.text = json["title"].stringValue
        var avatarURL = "http:" + json["member"]["avatar_large"].stringValue
        cell?.avatarImageView.sd_setImageWithURL(NSURL(string: avatarURL), placeholderImage:UIImage(named: "avatar_normal"))
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let json = self.datasource[indexPath.row] as JSON
        var vc = TopicDetailViewController()
        vc.json = json
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func onPullToFresh() {
        self.sendRequest()
    }

}

