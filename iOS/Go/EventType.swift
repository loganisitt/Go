//
//  EventType.swift
//  Go
//
//  Created by Logan Isitt on 6/11/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import ObjectMapper

class EventType: Mappable {
    
    var id: String!
    var name: String!
    var imagePath: String!
    var numOfPlayers: Int!
    
    init() {}
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        id  <- map["_id"]
        name    <- map["name"]
        imagePath   <- map["image_path"]
        numOfPlayers    <- map["num_of_players"]
    }
}