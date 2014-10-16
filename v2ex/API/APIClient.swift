//
//  APIClient.swift
//  v2ex
//
//  Created by liaojinxing on 14-10-16.
//  Copyright (c) 2014年 jinxing. All rights reserved.
//

import UIKit
import Alamofire

let APIRootURL = "http://www.v2ex.com/api/"

class APIClient {
   
    class var sharedInstance : APIClient {
        struct Static {
            static let instance : APIClient = APIClient()
        }
        return Static.instance
    }
    
    func getLatestTopics() {
        Alamofire.request(.GET, APIRootURL + "topics/latest.json")
            .responseJSON { (_, _, JSON, _) in
                println(JSON)
        }
    }
    
}
