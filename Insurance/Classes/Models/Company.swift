//
//  Copyright © 2015 NY. All rights reserved.
//

class Company: ModelObject {
    var id: NSNumber!
    var name = ""
    var address = ""
    var phoneNumber = ""
    var host = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "name" : "name",
            "address" : "address",
            "phone_number" : "phoneNumber",
            "host" : "host",
        ]
    }
}
