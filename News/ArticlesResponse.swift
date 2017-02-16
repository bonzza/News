//
//  ArticalList.swift
//  News
//
//  Created by Developer on 2/17/17.
//  Copyright © 2017 Fannec. All rights reserved.
//

import Foundation
import ObjectMapper


struct ArticlesResponse: Mappable {
    
    var articles: [Article]?
    var status: Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        articles    <- map["articles"]
        status      <- map["status"]
        
    }
    
}
