//
//  ResultType.swift
//  News
//
//  Created by Developer on 2/18/17.
//  Copyright © 2017 Fannec. All rights reserved.
//

import Foundation
import ObjectMapper


enum Result {
    case Success(obj: Mappable)
    case Error(error: Error)
}
