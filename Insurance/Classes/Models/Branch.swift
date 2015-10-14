//
//  Copyright (c) 2015 NY. All rights reserved.
//

class Branch: ModelObject {
    var id: NSNumber!
    var company: String = ""
    var name: String = ""
    var imageUrls = ListModel()
    var address: String = ""
    var latitude: String = ""
    var longitude: String = ""
    var phoneNumber: String = ""
    var type: String = ""
    var desc: String = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "company" : "company",
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
