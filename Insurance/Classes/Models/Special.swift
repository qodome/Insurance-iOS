//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Special: BaseModel {
    var cards = ListModel() // 手动补
    var id: NSNumber!
    var createdTime: NSDate!
    var isActive = false
    var title: NSString = ""
    var summary: NSString = ""
    var tags: NSString = ""
    var imageUrl: NSString = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "created_time" : "createdTime",
            "is_active" : "isActive",
            "title" : "title",
            "summary" : "summary",
            "tags" : "tags",
            "image_url" : "imageUrl",
        ]
    }
}
