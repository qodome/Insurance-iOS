//
//  Copyright © 2015 NY. All rights reserved.
//

class Enquiry: ModelObject {
    var id: NSNumber!
    var user: User?
    var imageUrls = ListModel()
    var content = ""
    var brand = ""
    var offers = ""
    var createdTime: NSDate!
    var isActive = false
    var carLicenseNumber = ""
    var ownerName = ""
    var model = ""
    var vehicleIdentificationNumber = ""
    var engineNumber = ""
    var status = ""
    var buyerMessage = ""
    var city = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "content" : "content",
            "brand" : "brand",
            "offers" : "offers",
            "created_time" : "createdTime",
            "is_active" : "isActive",
            "car_license_number" : "carLicenseNumber",
            "owner_name" : "ownerName",
            "model" : "model",
            "vehicle_identification_number" : "vehicleIdentificationNumber",
            "engine_number" : "engineNumber",
            "status" : "status",
            "buyer_message" : "buyerMessage",
            "city" : "city",
        ]
    }
}
