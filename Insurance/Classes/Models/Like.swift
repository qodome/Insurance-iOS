//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Like: BaseModel {
    var id: NSNumber!
    var idStr: NSString = ""
    var createdTime: NSDate!
    var user: User?
    var card: Card?
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "id_str" : "idStr",
            "created_time" : "createdTime",
        ]
    }
}
