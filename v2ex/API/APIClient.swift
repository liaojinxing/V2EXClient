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
    
    func getJSONData(path: NSString, parameters: [String : AnyObject]?, success: (JSON) -> Void, failure: (NSError) -> Void) {
        Alamofire.request(.GET, APIRootURL + path, parameters: parameters)
            .responseSwiftyJSON { (request, response, json, error) in
                if let err = error? {
                    failure(err)
                } else {
                    success(json)
                }
        }
    }
    
    func getLatestTopics(success: (JSON) -> Void, failure: (NSError) -> Void) {
        self.getJSONData("topics/latest.json", parameters: nil, success: success, failure: failure)
    }
    
    func getReplies(topicID: NSString, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["topic_id": topicID]
        self.getJSONData("replies/show.json", parameters: dict, success: success, failure: failure)
    }

}
