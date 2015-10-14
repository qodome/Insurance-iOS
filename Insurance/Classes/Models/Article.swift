//
//  Copyright (c) 2015 NY. All rights reserved.
//

class Article: ModelObject {
    var id: NSNumber!
    var user: User?
    var imageUrls = ListModel()
    var createdTime: NSDate!
    var isActive = false
    var title: String = ""
    var summary: String = ""
    var tags: String = ""
    var text: String = ""
    var imageUrl: String = ""
    var imageCount: NSNumber!
    var metaKeywords: String = ""
    var metaDescription: String = ""
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
