//
//  Copyright © 2015 NY. All rights reserved.
//

class User: BaseUser {
    var likes = ListModel() // 手动补
    var votes = ListModel() // 手动补
    var tags = ""
    var type = ""
    var company: Company?
    
    override class func getMapping() -> [String : String] {
        var dict = super.getMapping()
        dict["taqs"] = "tags"
        dict["type"] = "type"
        return dict
    }
}
