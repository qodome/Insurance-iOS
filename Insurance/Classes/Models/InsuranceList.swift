//
//  Copyright © 2015年 NY. All rights reserved.
//

class InsuranceList: ModelObject {
    var name = ""
    var options: NSNumber?
    
    override class func getMapping() -> [String : String] {
        return [
            "name" : "name",
            "options" : "options",
        ]
    }
}
