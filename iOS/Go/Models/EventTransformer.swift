//
//  EventTransformer.swift
//  Go
//
//  Created by Logan Isitt on 6/21/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit
import ObjectMapper

class EventTransformer: TransformType {
    
    typealias Object = Event
    typealias JSON = String
    
    required init() {
    }
    
    func transformFromJSON(value: AnyObject?) -> Object? {
        
        return Mapper<Object>().map(value)
    }
    
    func transformToJSON(value: Object?) -> JSON? {
        
        return value?.id
    }
}