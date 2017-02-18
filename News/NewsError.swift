//
//  NewsError.swift
//  News
//
//  Created by Developer on 2/18/17.
//  Copyright © 2017 Fannec. All rights reserved.
//

import Foundation

enum NewsError: Error {
    
    case ObjectMapping(Any)
    case Response(Error)
    case Unknown
    
}
