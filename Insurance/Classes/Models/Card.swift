//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Card: BaseModel {
    var id: NSNumber!
    var idStr: NSString = ""
    var user: User?
    var site: NSString = ""
    var createdTime: NSDate!
    var isActive = false
    var caption: NSString = ""
    var type: NSString = ""
    var imageUrl: NSString = ""
    var url: NSString = ""
    var tags: NSString = ""
    var brand: NSString = ""
    var objectId: NSNumber!
    var imageCount: NSNumber!
    var stream: NSString = ""
    var player: NSString = ""
    var tips: NSString = ""
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
            "brand" : "brand",
            "object_id" : "objectId",
            "image_count" : "imageCount",
            "stream" : "stream",
            "player" : "player",
            "tips" : "tips",
            "repost_count" : "repostCount",
        ]
    }
}
