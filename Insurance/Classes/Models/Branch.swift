//
//  Copyright © 2015 NY. All rights reserved.
//

class Branch: ModelObject {
    var id: NSNumber!
    var company: Company?
    var name = ""
    var credit: BusinessCredit?
    var tags = ListModel()
    var imageUrls = ListModel()
    var address = ""
    var latitude = ""
    var longitude = ""
    var phoneNumber = ""
    var type = ""
    var desc = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "name" : "name",
            "address" : "address",
            "latitude" : "latitude",
            "longitude" : "longitude",
            "phone_number" : "phoneNumber",
            "type" : "type",
            "desc" : "desc",
        ]
    }
}
