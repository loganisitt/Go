//
//  Client.swift
//  Drops
//
//  Created by Logan Isitt on 5/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit
import MobileCoreServices

import Alamofire

import ObjectMapper

import Socket_IO_Client_Swift

import SwiftyJSON

@objc protocol ClientDelegate {
    
    // Sign In & Sign Up
    optional func signInSuccessful()
    optional func signInFailed()
    
    // Events
    optional func receivedEvents(events: [Event])
}

class Client {
    
    let baseUrl = "http://localhost:8080"
    //    let baseUrl = "http://192.168.2.8:8080"
    //    let baseUrl = "http://10.132.104.97:8080"
    
    var delegate: ClientDelegate!
    
    var socket: SocketIOClient! //(socketURL: baseUrl)
    
    var currentUser: User!
    
    class var sharedInstance: Client {
        struct Singleton {
            static let instance = Client()
        }
        return Singleton.instance
    }
    
    init() {
        
    }
    
    // MARK: - Authentication
    
    func signinWithFacebook(accessToken: String) {
        
        var url = baseUrl + "/auth/facebook?access_token=" + accessToken
        
        var isSignedIn: Bool = false
        
        Alamofire.request(.POST, url).responseJSON() {
            (_, _, data, error) in
            
            if (data != nil) {
                self.currentUser = Mapper<User>().map(data)!
                println(self.currentUser.name)
                self.delegate.signInSuccessful!()
            }
            else {
                self.delegate.signInFailed!()
            }
        }
    }
    
    func signinWith(email: String, password: String) {
        
        var url = baseUrl + "/auth/login"
        
        let parameters = [ "email": email, "password": password]
        
        var isSignedIn: Bool = false
        
        Alamofire.request(.POST, url, parameters: parameters).responseJSON() {
            (_, _, data, error) in
            
            if (data != nil) {
                self.currentUser = Mapper<User>().map(data)!
                self.delegate.signInSuccessful!()
            }
            else {
                self.delegate.signInFailed!()
            }
        }
    }
    
    func signUpWith(email: String, password: String) {
        
        var url = baseUrl + "/auth/signup"
        
        let parameters = ["email": email, "password": password]
        
        var isSignedIn: Bool = false
        
        Alamofire.request(.POST, url, parameters: parameters).responseJSON() {
            (_, _, data, error) in
            
            if (data != nil) {
                var user: User = Mapper<User>().map(data)!
                println(user)
                self.delegate.signInSuccessful!()
            }
            else {
                self.delegate.signInFailed!()
            }
        }
    }
    
    // MARK: - Event
    
    // Create
    
    func createEvent(event: Event, completionHandler: (error: NSError?) -> ()) {
        
        let parameters = Mapper().toJSON(event)
        makeEvent(parameters, completionHandler: completionHandler)
    }
    
    func makeEvent(parameters: Dictionary<String, AnyObject>, completionHandler: (error: NSError?) -> ()) {
        
        var url = baseUrl + "/api/event"
        
        Alamofire.request(.POST, url, parameters: parameters).validate().response { request, response, responseObject, error in
            if (responseObject != nil) {
                completionHandler(error: error)
            }
            else {
                completionHandler(error: error)
            }
        }
    }
    
    // All Events
    func allEvents(completionHandler: (events: [Event], error: NSError?) -> ()) {
        getAllEvents(completionHandler)

    }
    
    func getAllEvents(completionHandler: (events: [Event], error: NSError?) -> ()) {
        
        var url = baseUrl + "/api/event"
        
        Alamofire.request(.GET, url).validate().responseJSON() { request, response, responseObject, error in

            if (responseObject != nil) {
                println(responseObject)
                var events: [Event] = Mapper<Event>().mapArray(responseObject)!
                completionHandler(events: events, error: error)
            }
            else {
                completionHandler(events: [], error: error)
            }
        }
    }
    
    // Join
    
    func joinEvent(event: Event, completionHandler: (event: Event?, error: NSError?) -> ()) {
        postJoinEvent(event, completionHandler: completionHandler)
    }
    
    func postJoinEvent(event: Event, completionHandler: (event: Event?, error: NSError?) -> ()) {
        var url = baseUrl + "/api/event/join"
        
        let parameters =
        ["user": currentUser.id,
         "event": event.id]

        
        Alamofire.request(.POST, url, parameters: parameters).validate().responseJSON() { request, response, responseObject, error in
            
            if (responseObject != nil) {
                var event: Event = Mapper<Event>().map(responseObject)!
                completionHandler(event: event, error: error)
            }
            else {
                completionHandler(event: nil, error: error)
            }
        }
    }
    
    // Leave 
    
    func leaveEvent(event: Event, completionHandler: (event: Event?, error: NSError?) -> ()) {
        postLeaveEvent(event, completionHandler: completionHandler)
    }
    
    func postLeaveEvent(event: Event, completionHandler: (event: Event?, error: NSError?) -> ()) {
        var url = baseUrl + "/api/event/leave"
        
        let parameters =
        ["user": currentUser.id,
         "event": event.id]
        
        
        Alamofire.request(.POST, url, parameters: parameters).validate().responseJSON() { request, response, responseObject, error in
            
            if (responseObject != nil) {
                var event: Event = Mapper<Event>().map(responseObject)!
                completionHandler(event: event, error: error)
            }
            else {
                completionHandler(event: nil, error: error)
            }
        }
    }
    
    //
    
    func basicSearchFor(query: String) -> Bool {
        
        var url = baseUrl + "/api/event/search"
        
        var parameters = ["name": query]
        Alamofire.request(.GET, url, parameters: parameters ).validate().responseJSON() {
            (_, _, data, error) in
            
            println(data)
            
            var json = JSON(data!)
            
            var events: [Event] = Mapper<Event>().mapArray(json["hits"]["hits"].arrayObject)!
            
            self.delegate.receivedEvents!(events)
        }
        return true
    }
    
    func makeBid(event: Event) -> Bool {
        
        var urlString = baseUrl + "/api/event/bid"
        
        var parameters = ["id": currentUser.id, "offer": NSNumber(double: 29.99), "bidder": currentUser.id]
        
        Alamofire.request(.GET, urlString, parameters: parameters).validate().responseJSON() {
            (_, _, data, error) in
            
            println(data)
        }
        return true
    }
    
    func watch(event: Event) -> Bool {
        
        var urlString = baseUrl + "/api/event/watch"
        
        var parameters = ["id": event.id, "watcher": currentUser.id]
        
        Alamofire.request(.GET, urlString, parameters: parameters).validate().responseJSON() {
            (_, _, data, error) in
            
            println(data)
        }
        return true
    }
    
    // MARK: - EventType
    
    func getAllEventTypes(completionHandler: (eventTypes: [EventType], error: NSError?) -> ()) {
        makeCall(completionHandler)
    }
    
    func makeCall(completionHandler: (eventTypes: [EventType], error: NSError?) -> ()) {
        
        var urlString = baseUrl + "/api/eventType"
        
        Alamofire.request(.GET, urlString).validate().responseJSON { request, response, responseObject, error in
            
            if (responseObject != nil) {
                
                var eventTypes: [EventType] = Mapper<EventType>().mapArray(responseObject)!
                
                completionHandler(eventTypes: eventTypes, error: error)
            }
            else {
                completionHandler(eventTypes: [], error: error)
            }
        }
    }
    
    // MARK: - Socket
    
    func connectSocket() {
        socket = SocketIOClient(socketURL: baseUrl)
        
        socket.onAny(socketHandler)
        
        socket.connect()
    }
    
    func disconnectSocket() {
        if socket.connected {
            socket.disconnect(fast: false)
        }
    }
    
    func socketHandler(anyEvent: SocketAnyEvent) -> Void {
        if anyEvent.event == "connect" {
            println("Event: \(anyEvent.event)")
            println("\tItems: \(anyEvent.items)")
            
            socket.emit("load", ["a": "c", "b": "d"])
        }
        else if anyEvent.event == "peopleinchat" {
            println("Event: \(anyEvent.event)")
            println("\tItems: \(anyEvent.items)")
            
            socket.emit("login", ["user":"Sim", "avatar":"laisitt@gmail.com", "id":["a": "c", "b": "d"]])
        }
        else if anyEvent.event == "receive" {
            println("Event: \(anyEvent.event)")
            println("\tItem: \(anyEvent.items![0])")
            
            let message = Mapper<Message>().map(anyEvent.items![0])
        }
        else {
            println("Event: \(anyEvent.event)")
            println("\tItems: \(anyEvent.items)")
        }
    }
    
    func send(message: Message) {
        println("Sending: \(message)")
        
        let JSONString = Mapper().toJSONString(message, prettyPrint: true)
        let JSONData = Mapper().toJSON(message)
        
        socket.emit("msg", JSONData)
    }
    
    // MARK: - Helpers
    func createBodyWithParameters(parameters: [String: AnyObject]?, filePathKey: String?, paths: [String]?, boundary: String) -> NSData {
        
        let body = NSMutableData()
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        if paths != nil {
            for path in paths! {
                let filename = path.lastPathComponent
                let data = NSData(contentsOfFile: path)
                let mimetype = mimeTypeForPath(path)
                
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
                body.appendString("Content-Type: \(mimetype)\r\n\r\n")
                body.appendData(data!)
                body.appendString("\r\n")
            }
        }
        
        body.appendString("--\(boundary)--\r\n")
        return body
    }
    
    /// Create boundary string for multipart/form-data request
    ///
    /// :returns:            The boundary string that consists of "Boundary-" followed by a UUID string.
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    /// Determine mime type on the basis of extension of a file.
    ///
    /// This requires MobileCoreServices framework.
    ///
    /// :param: path         The path of the file for which we are going to determine the mime type.
    ///
    /// :returns:            Returns the mime type if successful. Returns application/octet-stream if unable to determine mime type.
    
    func mimeTypeForPath(path: String) -> String {
        let pathExtension = path.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream";
    }
}