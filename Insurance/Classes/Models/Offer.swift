//
//  Copyright © 2015 NY. All rights reserved.
//

class Offer: ModelObject {
    var id: NSNumber!
    var user: User?
    var idStr = ""
    var imageUrls = ListModel()
    var content = ""
    var brand = ""
    var agent = ""
    var createdTime: NSDate!
    var isActive = false
    var city = ""
    var carLicenseNumber = ""
    var ownerName = ""
    var phoneNumber = ""
    var model = ""
    var vehicleIdentificationNumber = ""
    var engineNumber = ""
    var agentId: NSNumber!
    var status: NSNumber!
    var mandatory: NSNumber!
    var damage: NSNumber!
    var thirdParty: NSNumber!
    var theft: NSNumber!
    var driver: NSNumber!
    var passenger: NSNumber!
    var windscreen: NSNumber!
    var scratch: NSNumber!
    var fire: NSNumber!
    var waterlogged: NSNumber!
    var equipment: NSNumber!
    var specifiedFactory: NSNumber!
    var spDamage: NSNumber!
    var spThirdParty: NSNumber!
    var spTheft: NSNumber!
    var spStaff: NSNumber!
    var spAdditional: NSNumber!
    var motorTaxes: NSNumber!
    var quotedPrice: NSNumber!
    var remark = ""
    var enquiry: Enquiry?
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "id_str" : "idStr",
            "content" : "content",
            "brand" : "brand",
            "agent" : "agent",
            "created_time" : "createdTime",
            "is_active" : "isActive",
            "city" : "city",
            "car_license_number" : "carLicenseNumber",
            "owner_name" : "ownerName",
            "phone_number" : "phoneNumber",
            "model" : "model",
            "vehicle_identification_number" : "vehicleIdentificationNumber",
            "engine_number" : "engineNumber",
            "agent_id" : "agentId",
            "status" : "status",
            "mandatory" : "mandatory",
            "damage" : "damage",
            "third_party" : "thirdParty",
            "theft" : "theft",
            "driver" : "driver",
            "passenger" : "passenger",
            "windscreen" : "windscreen",
            "scratch" : "scratch",
            "fire" : "fire",
            "waterlogged" : "waterlogged",
            "equipment" : "equipment",
            "specified_factory" : "specifiedFactory",
            "sp_damage" : "spDamage",
            "sp_third_party" : "spThirdParty",
            "sp_theft" : "spTheft",
            "sp_staff" : "spStaff",
            "sp_additional" : "spAdditional",
            "motor_taxes" : "motorTaxes",
            "quoted_price" : "quotedPrice",
            "remark" : "remark",
        ]
    }
}
