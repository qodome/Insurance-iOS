//
//  Copyright (c) 2015 NY. All rights reserved.
//

class Question: ModelObject {
    var id: NSNumber!
    var user: User?
    var createdTime: NSDate!
    var isActive = false
    var title = ""
    var summary = ""
    var tags = ""
    
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
