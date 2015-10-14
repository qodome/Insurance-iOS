//
//  Copyright (c) 2015 NY. All rights reserved.
//

class Comment: ModelObject {
    var id: NSNumber!
    var idStr: String = ""
    var createdTime: NSDate!
    var user: User?
    var text: String = ""
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
