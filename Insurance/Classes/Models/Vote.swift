//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Vote: ModelObject {
    var id: NSNumber!
    var idStr: NSString = ""
    var user: User?
    var createdTime: NSDate!
    var answerId: NSNumber!
    var type: NSString = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "id_str" : "idStr",
            "created_time" : "createdTime",
            "answer_id" : "answerId",
            "type" : "type",
        ]
    }
}
