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


public typealias ApiCompletionBlock = (_ result: Mappable?, _ error: NSError?) -> Void

class NewsAPI: NSObject {
    
    private static let apiKey = "810f9b2d3f4f4193b30e660db996f9d8"
    
    
    static func request(_ url: URLConvertible,
                        method: HTTPMethod = .get,
                        mappableType: Mappable.Type,
                        parameters: Parameters? = nil,
                        completeBlock: @escaping ApiCompletionBlock
        )
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
