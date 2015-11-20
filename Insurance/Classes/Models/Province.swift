//
//  Copyright © 2015年 NY. All rights reserved.
//

class Province: ModelObject {
    var name = ""
    var code: NSNumber!
    var state: NSNumber!
    var cities = ListModel()
    
    override class func getMapping() -> [String : String] {
        return [
            "name" : "name",
            "code" : "code",
            "state" : "state",
        ]
    }
}
