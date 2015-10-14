//
//  Copyright (c) 2015 NY. All rights reserved.
//

class InsurancePolicy: ModelObject {
    var id: NSNumber!
    var idStr = ""
    var user: User?
    var settlementRecords = ""
    var orderIdStr = ""
    var content = ""
    var createdTime: NSDate!
    var isActive = false
    var idCardNumber = ""
    var phoneNumber = ""
    var skuId: NSNumber!
    var orderId: NSNumber!
    var insuranceAmount: NSNumber!
    var name = ""
    var startTime: NSDate!
    var endTime: NSDate!
    var insurantName = ""
    var insurantIdCardNumber = ""
    var openId = ""
    var mchId = ""
    var flightNumber = ""
    var desc = ""
    var status: NSNumber!
    var type: NSNumber!
    var carLicenseNumber = ""
    var remark = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "id_str" : "idStr",
            "settlement_records" : "settlementRecords",
            "order_id_str" : "orderIdStr",
            "content" : "content",
            "created_time" : "createdTime",
            "is_active" : "isActive",
            "id_card_number" : "idCardNumber",
            "phone_number" : "phoneNumber",
            "sku_id" : "skuId",
            "order_id" : "orderId",
            "insurance_amount" : "insuranceAmount",
            "name" : "name",
            "start_time" : "startTime",
            "end_time" : "endTime",
            "insurant_name" : "insurantName",
            "insurant_id_card_number" : "insurantIdCardNumber",
            "open_id" : "openId",
            "mch_id" : "mchId",
            "flight_number" : "flightNumber",
            "description" : "desc",
            "status" : "status",
            "type" : "type",
            "car_license_number" : "carLicenseNumber",
            "remark" : "remark",
        ]
    }
}
