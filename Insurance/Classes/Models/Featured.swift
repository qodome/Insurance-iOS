//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Featured: BaseModel {
    var id: NSNumber!
    var user: User?
    var createdTime: NSDate!
    var isActive = false
    var title: NSString = ""
    var summary: NSString = ""
    var tags: NSString = ""
    var objectId: NSNumber!
    var type: NSString = ""
    var imageUrl: NSString = ""
    
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
