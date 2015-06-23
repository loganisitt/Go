//
//  Event.swift
//  Drops
//
//  Created by Logan Isitt on 5/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import ObjectMapper

class Event: Mappable {
    
    var id: String?
    var admin: User!
    
    var name: String!
    
    var eventType: EventType!
    
    var privacy: Bool!
    
    var date: NSDate!
    
    var locationName: String!
    var location: [Double]!
    
    var maxAttendees: Int!

    var ageRestrictions: Bool!
    var minAge: Int!
    var maxAge: Int!
    
    var attendees: [User]?
    
    init() {}
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        id  <- map["_id"]
        admin   <- (map["admin"], UserTransformer())
        name    <- map["name"]
        eventType   <- (map["event_type"], EventTypeTransformer())
        privacy <- map["privacy"]
        date    <- (map["date"], DateTransform())
        locationName    <- map["location_name"]
        location    <- map["location"]
        maxAttendees    <- map["max_attendees"]
        ageRestrictions <- map["age_restriction"]
        minAge  <- map["min_age"]
        maxAge  <- map["max_age"]
        attendees  <- map["attendees"]
    }
}