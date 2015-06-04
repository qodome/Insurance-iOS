//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class Category: BaseModel {
    var name: NSString = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "name" : "name"
        ]
    }
}
