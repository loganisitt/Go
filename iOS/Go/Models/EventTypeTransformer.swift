//
//  EventTypeTransformer.swift
//  Go
//
//  Created by Logan Isitt on 6/19/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit
import ObjectMapper

class EventTypeTransformer: TransformType {
    
    typealias Object = EventType
    typealias JSON = String
    
    required init() {
    }
    
    func transformFromJSON(value: AnyObject?) -> Object? {
        
        return Mapper<EventType>().map(value)
    }
    
    func transformToJSON(value: Object?) -> JSON? {
        
        return value?.id
    }
}
