//
//  Article.swift
//  News
//
//  Created by Developer on 2/16/17.
//  Copyright © 2017 Fannec. All rights reserved.
//

import UIKit
import ObjectMapper


struct Article: Mappable {
    
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var image: String?
    var date: Date?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        author       <- map["author"]
        title        <- map["title"]
        description  <- map["description"]
        url          <- map["url"]
        image        <- map["urlToImage"]
        date         <- (map["publishedAt"], DateTransform())
        
    }

}
