//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Question: BaseModel {
    var id: NSNumber!
    var user: User?
    var createdTime: NSDate!
    var isActive = false
    var title: NSString = ""
    var summary: NSString = ""
    var tags: NSString = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "created_time" : "createdTime",
            "is_active" : "isActive",
            "title" : "title",
            "summary" : "summary",
            "tags" : "tags",
        ]
    }
}
