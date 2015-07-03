//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Comment: BaseModel {
    var id: NSNumber!
    var idStr: NSString = ""
    var createdTime: NSDate!
    var user: User?
    var text: NSString = ""
    var likeCount: NSNumber!
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "id_str" : "idStr",
            "created_time" : "createdTime",
            "text" : "text",
            "like_count" : "likeCount",
        ]
    }
}
