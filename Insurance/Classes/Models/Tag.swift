//
//  Copyright © 2015 NY. All rights reserved.
//

class Tag: ModelObject {
    var id: NSNumber!
    var user: User?
    var createdTime: NSDate!
    var isActive = false
    var name = ""
    var type = ""
    var imageUrl = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "created_time" : "createdTime",
            "is_active" : "isActive",
            "name" : "name",
            "type" : "type",
            "image_url" : "imageUrl",
        ]
    }
}
