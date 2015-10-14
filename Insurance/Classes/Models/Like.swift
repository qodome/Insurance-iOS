//
//  Copyright (c) 2015 NY. All rights reserved.
//

class Like: ModelObject {
    var id: NSNumber!
    var idStr = ""
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
