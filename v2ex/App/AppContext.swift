//
//  AppContext.swift
//  v2ex
//
//  Created by liaojinxing on 14/10/21.
//  Copyright (c) 2014年 jinxing. All rights reserved.
//

import UIKit

class AppContext {
   
    private let kNodesKey = "nodes"
    
    class var sharedInstance : AppContext {
    struct Static {
        static let instance : AppContext = AppContext()
        }
        return Static.instance
    }
    
    func saveNodes(nodes:AnyObject) {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(nodes), forKey: kNodesKey)
        userDefaults.synchronize()
    }
    
    func getNodes() -> JSON? {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        var data: AnyObject? = userDefaults.objectForKey(kNodesKey)
        if let obj: AnyObject = data? {
            var json: AnyObject? = NSKeyedUnarchiver.unarchiveObjectWithData(obj as NSData)
            return JSON(json!)
        } else {
            return nil
        }
    }
    
}
