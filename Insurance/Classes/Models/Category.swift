//
//  Copyright © 2015年 NY. All rights reserved.
//

class Category: ModelObject {
    var name = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "name" : "name"
        ]
    }
}
