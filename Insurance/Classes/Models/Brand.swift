//
//  Copyright © 2015年 NY. All rights reserved.
//

class Brand: ModelObject {
    var id: NSNumber!
    var image_url = ""
    var name = ""
    var tags = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "image_url" : "image_url",
            "name" : "name",
            "tags" : "tags"
        ]
    }
}
