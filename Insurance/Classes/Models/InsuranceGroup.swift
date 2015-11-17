//
//  Copyright © 2015年 NY. All rights reserved.
//

class InsuranceGroup: ListModel {
    var name = ""
    var insurances  = ListModel()
    
    override class func getMapping() -> [String : String] {
        var dict = super.getMapping()
        dict["name"] = "name"
        return dict
    }
}
