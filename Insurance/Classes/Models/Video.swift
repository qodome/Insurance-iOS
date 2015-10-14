//
//  Copyright (c) 2015 NY. All rights reserved.
//

class Video: ModelObject {
    var id: NSNumber!
    var user: User?
    var createdTime: NSDate!
    var isActive = false
    var title: String = ""
    var summary: String = ""
    var tags: String = ""
    var imageUrl: String = ""
    var url: String = ""
    var stream: String = ""
    var player: String = ""
    var playerI: String = ""
    var playerQ: String = ""
    var playerY: String = ""
    
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
