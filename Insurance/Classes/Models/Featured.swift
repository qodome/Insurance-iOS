//
//  Copyright © 2015 NY. All rights reserved.
//

class Featured: ModelObject {
    var id: NSNumber!
    var user: User?
    var imageUrls = ListModel()
    var createdTime: NSDate!
    var isActive = false
    var title = ""
    var summary = ""
    var tags = ""
    var objectId: NSNumber!
    var type = ""
    var imageUrl = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "created_time" : "createdTime",
            "is_active" : "isActive",
            "title" : "title",
            "summary" : "summary",
            "tags" : "tags",
            "object_id" : "objectId",
            "type" : "type",
            "image_url" : "imageUrl",
        ]
    }
}
