//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class Category: ModelObject {
    var name: String = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "name" : "name"
        ]
    }
}
