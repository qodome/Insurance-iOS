//
//  Copyright (c) 2015 NY. All rights reserved.
//

class Card: ModelObject {
    var article: Article? // 手动补
    var video: Video? // 手动补
    var comments = ListModel() // 手动补
    var likes = ListModel() // 手动补
    var id: NSNumber!
    var idStr: String = ""
    var user: User?
    var imageUrls = ListModel()
    var site: String = ""
    var createdTime: NSDate!
    var isActive = false
    var caption: String = ""
    var type: String = ""
    var imageUrl: String = ""
    var url: String = ""
    var tags: String = ""
    var objectId: NSNumber!
    var imageCount: NSNumber!
    var stream: String = ""
    var player: String = ""
    var tips: String = ""
    var repostCount: NSNumber!
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "id_str" : "idStr",
            "site" : "site",
            "created_time" : "createdTime",
            "is_active" : "isActive",
            "caption" : "caption",
            "type" : "type",
            "image_url" : "imageUrl",
            "url" : "url",
            "tags" : "tags",
            "object_id" : "objectId",
            "image_count" : "imageCount",
            "stream" : "stream",
            "player" : "player",
            "tips" : "tips",
            "repost_count" : "repostCount",
        ]
    }
}
