//
//  Copyright © 2015 NY. All rights reserved.
//

class Enquiry: ModelObject {
    var id: NSNumber!
    var user: User?
    var content = ""
    var images = ""
    var brand = ""
    var offers = ""
    var enquiryStatus = ""
    var createdTime: NSDate!
    var isActive = false
    var idCardNumber = ""
    var phoneNumber = ""
    var imageUrls = ListModel()
    var carLicenseNumber = ""
    var insurantName = ""
    var model = ""
    var vehicleIdentificationNumber = ""
    var engineNumber = ""
    var status = ""
    var buyerMessage = ""
    var city = ""
    var cityCode: NSNumber!
    var carBoughtTime: NSDate!
    var carModelCode = ""
    var insuranceStartDate: NSDate!
    var remark = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "content" : "content",
            "images" : "images",
            "brand" : "brand",
            "offers" : "offers",
            "enquiry_status" : "enquiryStatus",
            "created_time" : "createdTime",
            "is_active" : "isActive",
            "id_card_number" : "idCardNumber",
            "phone_number" : "phoneNumber",
            "car_license_number" : "carLicenseNumber",
            "insurant_name" : "insurantName",
            "model" : "model",
            "vehicle_identification_number" : "vehicleIdentificationNumber",
            "engine_number" : "engineNumber",
            "status" : "status",
            "buyer_message" : "buyerMessage",
            "city_code" : "cityCode",
            "car_bought_time" : "carBoughtTime",
            "car_model_code" : "carModelCode",
            "insurance_start_date" : "insuranceStartDate",
            "remark" : "remark",
            "city" : "city",
        ]
    }
}
