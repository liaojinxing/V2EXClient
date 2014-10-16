//
//  ViewController.swift
//  v2ex
//
//  Created by liaojinxing on 14-10-16.
//  Copyright (c) 2014年 jinxing. All rights reserved.
//

import UIKit

class TopicsViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "V2ex"

        APIClient.sharedInstance.getLatestTopics({ (json) -> Void in
            if json.type == Type.Array {
                self.datasource = json.arrayValue
            }
        }, failure: { (error) -> Void in
            print(error)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.datasource != nil) {
            println(self.datasource.count)
            return self.datasource.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(TopicCellID) as? TopicCell
        let json = self.datasource[indexPath.row] as JSON
        cell?.titleLabel.text = json["title"].stringValue
        return cell!
    }


}

