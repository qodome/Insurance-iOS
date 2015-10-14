//
//  Copyright (c) 2015 NY. All rights reserved.
//

class Company: ModelObject {
    var id: NSNumber!
    var name: String = ""
    var address: String = ""
    var phoneNumber: String = ""
    var host: String = ""
    
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
