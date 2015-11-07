//
//  Copyright © 2015 NY. All rights reserved.
//

class Article: ModelObject {
    var id: NSNumber!
    var user: User?
    var imageUrls = ListModel()
    var createdTime: NSDate!
    var isActive = false
    var title = ""
    var summary = ""
    var tags = ""
    var text = ""
    var imageUrl = ""
    var imageCount: NSNumber!
    var metaKeywords = ""
    var metaDescription = ""
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
            "meta_keywords" : "metaKeywords",
            "meta_description" : "metaDescription",
            "author_id" : "authorId",
        ]
    }
}
