//
//  NodesViewController.swift
//  v2ex
//
//  Created by liaojinxing on 14/10/20.
//  Copyright (c) 2014年 jinxing. All rights reserved.
//

import UIKit

class NodesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var collectionView: UICollectionView?
    var dataArray: Array<JSON>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "全部节点"
        self.view.backgroundColor = UIColor.whiteColor()
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(self.view.bounds.size.width / 2 - 10, 44)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.registerClass(NodeCell.self, forCellWithReuseIdentifier: "NodeCell")
        self.view.addSubview(self.collectionView!)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            var nodes = AppContext.sharedInstance.getNodes()
            dispatch_async(dispatch_get_main_queue(), {
                if let json = nodes? {
                    self.dataArray = json.arrayValue
                    self.collectionView?.reloadData()
                } else {
                    self.sendRequest()
                }
            })
        })
    }
    
    func sendRequest() {
        APIClient.sharedInstance.getNodes({ (json) -> Void in
            if json.type == Type.Array {
                self.dataArray = json.arrayValue
                self.collectionView?.reloadData()
                AppContext.sharedInstance.saveNodes(json.object)
            }
            }) { (error) -> Void in
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let array = self.dataArray? {
            return array.count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("NodeCell", forIndexPath: indexPath) as NodeCell
        
        if let array = self.dataArray? {
            let json = array[indexPath.row]
            cell.nameLabel?.text = json["title"].stringValue
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let array = self.dataArray? {
            let json = array[indexPath.row]
            var vc = TopicsViewController()
            vc.nodeJSON = json
            self.navigationController?.pushViewController(vc, animated: true)
        }
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
    }
    
}
