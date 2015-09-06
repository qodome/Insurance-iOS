//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Tag: ModelObject {
    var id: NSNumber!
    var user: User?
    var createdTime: NSDate!
    var name: NSString = ""
    var type: NSString = ""
    var imageUrl: NSString = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "created_time" : "createdTime",
            "name" : "name",
            "type" : "type",
            "image_url" : "imageUrl",
        ]
    }
}
