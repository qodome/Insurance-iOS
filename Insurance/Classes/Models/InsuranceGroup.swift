//
//  Copyright © 2015年 NY. All rights reserved.
//

class InsuranceGroup: ModelObject {
    var name = ""
    var insurances  = ListModel()
    
    override class func getMapping() -> [String : String] {
        return [
            "name" : "name",
        ]
    }
}
