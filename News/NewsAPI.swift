//
//  NewsAPI.swift
//  News
//
//  Created by Developer on 2/16/17.
//  Copyright © 2017 Fannec. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SwiftyJSON


public typealias ApiCompletionBlock = (_ result: Mappable?, _ error: NSError?) -> Void

class NewsAPI: NSObject {
    
    private static let apiKey = "810f9b2d3f4f4193b30e660db996f9d8"
    
    
    static func request(_ url: URLConvertible,
                        method: HTTPMethod = .get,
                        mappableType: Mappable.Type,
                        parameters: Parameters? = nil,
                        completeBlock: @escaping ApiCompletionBlock)
    {
        /* Add api key for all request */
        var param = parameters ?? [String:AnyObject]()
        param["apikey"] = apiKey
        
        Alamofire
            .request(url, method: method, parameters: param)
            .responseJSON { (response) in
                switch response.result {
                case .success(let responseJSON):
                    if let obj = mappableType.init(map: Map(mappingType: .fromJSON, JSON: responseJSON as! [String : Any])) {
                        completeBlock(obj, nil)
                    } else {
                        completeBlock(nil, nil)
                    }
                case .failure(let err):
                    print(err)
                }
                
        }
    }
}

/* For Test */
extension NewsAPI {
    
    static func request(path: String,
                        mappableType: Mappable.Type,
                        completeBlock: @escaping ApiCompletionBlock)
    {
        if let path = Bundle.main.path(forResource: "acticles_ok", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    let obj = mappableType.init(map: Map(mappingType: .fromJSON, JSON: jsonObj.dictionary!))
                    completeBlock(obj, nil)
                    print("jsonData:\(jsonObj)")
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        
    }
}
