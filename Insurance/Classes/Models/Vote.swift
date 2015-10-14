//
//  Copyright (c) 2015 NY. All rights reserved.
//

class Vote: ModelObject {
    var id: NSNumber!
    var idStr = ""
    var user: User?
    var createdTime: NSDate!
    var isActive = false
    var answerId: NSNumber!
    var type = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "id_str" : "idStr",
            "created_time" : "createdTime",
            "is_active" : "isActive",
            "answer_id" : "answerId",
            "type" : "type",
        ]
    }
}
