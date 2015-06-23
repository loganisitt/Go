//
//  UserTransformer.swift
//  Go
//
//  Created by Logan Isitt on 6/19/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit
import ObjectMapper

class UserTransformer: TransformType {
   
    typealias Object = User
    typealias JSON = String
    
    required init() {
    }
    
    func transformFromJSON(value: AnyObject?) -> Object? {
        
        return Mapper<User>().map(value)
    }
    
    func transformToJSON(value: Object?) -> JSON? {
        
        return value?.id
    }
}
