//
//  Copyright © 2015 NY. All rights reserved.
//

class Health: ModelObject {
    var userId: NSNumber!
    var createdTime: NSDate!
    var updatedTime: NSDate!
    var records = ""
    var recordCount: NSNumber!
    
    override class func getMapping() -> [String : String] {
        return [
            "user_id" : "userId",
            "created_time" : "createdTime",
            "updated_time" : "updatedTime",
            "records" : "records",
            "record_count" : "recordCount",
        ]
    }
}
