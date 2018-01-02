//
//  Post.swift
//  DebugApp
//

//

import Foundation

class Post: NSObject {
    
    var id: String?
    var listText: [String]?
    var numLikes: NSNumber?
    var numComments: NSNumber?
    var creationDate: String?
    
    
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String
        self.listText = dictionary["listText"] as? [String]//
        self.numLikes = dictionary["numLikes"] as? NSNumber
        self.numComments = dictionary["numComments"] as? NSNumber
        self.creationDate = dictionary["creationDate"] as? String
        
        
    }
}

