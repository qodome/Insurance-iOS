//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Article: BaseModel {
    var id: NSNumber!
    var user: User?
    var createdTime: NSDate!
    var isActive = false
    var title: NSString = ""
    var summary: NSString = ""
    var tags: NSString = ""
    var text: NSString = ""
    var imageUrl: NSString = ""
    var imageCount: NSNumber!
    var authorId: NSNumber!
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "created_time" : "createdTime",
            "is_active" : "isActive",
            "title" : "title",
            "summary" : "summary",
            "tags" : "tags",
            "text" : "text",
            "image_url" : "imageUrl",
            "image_count" : "imageCount",
            "author_id" : "authorId",
        ]
    }
}
