//
//  Copyright (c) 2015 NY. All rights reserved.
//

class Special: ModelObject {
    var cards = ListModel() // 手动补
    var id: NSNumber!
    var createdTime: NSDate!
    var isActive = false
    var title: String = ""
    var summary: String = ""
    var tags: String = ""
    var imageUrl: String = ""
    
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
