//
//  Copyright (c) 2015 NY. All rights reserved.
//

class Enquiry: ModelObject {
    var id: NSNumber!
    var user: User?
    var imageUrls = ListModel()
    var content: String = ""
    var brand: String = ""
    var offers: String = ""
    var createdTime: NSDate!
    var isActive = false
    var carLicenseNumber: String = ""
    var ownerName: String = ""
    var model: String = ""
    var vehicleIdentificationNumber: String = ""
    var engineNumber: String = ""
    var status: String = ""
    var buyerMessage: String = ""
    var city: String = ""
    
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
