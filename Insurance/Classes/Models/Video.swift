//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Video: ModelObject {
    var id: NSNumber!
    var user: User?
    var createdTime: NSDate!
    var isActive = false
    var title: NSString = ""
    var summary: NSString = ""
    var tags: NSString = ""
    var imageUrl: NSString = ""
    var url: NSString = ""
    var stream: NSString = ""
    var player: NSString = ""
    var playerI: NSString = ""
    var playerQ: NSString = ""
    var playerY: NSString = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "created_time" : "createdTime",
            "is_active" : "isActive",
            "title" : "title",
            "summary" : "summary",
            "tags" : "tags",
            "image_url" : "imageUrl",
            "url" : "url",
            "stream" : "stream",
            "player" : "player",
            "player_i" : "playerI",
            "player_q" : "playerQ",
            "player_y" : "playerY",
        ]
    }
}
