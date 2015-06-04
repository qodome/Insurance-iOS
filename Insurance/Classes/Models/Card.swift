//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Card: BaseModel {
    var id: NSNumber!
    var idStr: NSString = ""
    var image: NSString = ""
    var user: User?
    var created: NSDate!
    var isActive = false
    var userId: NSNumber!
    var username: NSString = ""
    var userImageUrl: NSString = ""
    var objectId: NSNumber!
    var type: NSString = ""
    var caption: NSString = ""
    var imageUrl: NSString = ""
    var imagesCount: NSNumber!
    var stream: NSString = ""
    var player: NSString = ""
    var site: NSString = ""
    var url: NSString = ""
    var likesCount: NSNumber!
    var commentsCount: NSNumber!
    var tags: NSString = ""
    var brand: NSString = ""
    var tips: NSString = ""
    
    override class func getMapping() -> Dictionary<String, String> {
        return [
            "id" : "id",
            "id_str" : "idStr",
            "image" : "image",
            "user" : "user",
            "created" : "created",
            "is_active" : "isActive",
            "user_id" : "userId",
            "username" : "username",
            "user_image_url" : "userImageUrl",
            "object_id" : "objectId",
            "type" : "type",
            "caption" : "caption",
            "image_url" : "imageUrl",
            "images_count" : "imagesCount",
            "stream" : "stream",
            "player" : "player",
            "site" : "site",
            "url" : "url",
            "likes_count" : "likesCount",
            "comments_count" : "commentsCount",
            "tags" : "tags",
            "brand" : "brand",
            "tips" : "tips",
        ]
    }
}
