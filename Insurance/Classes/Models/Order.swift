//
//  Copyright (c) 2015 NY. All rights reserved.
//

class Order: ModelObject {
    var id: NSNumber!
    var idStr: String = ""
    var imageUrls = ListModel()
    var user: User?
    var product: Product?
    var prepayList: String = ""
    var insurancePolicies: String = ""
    var createdTime: NSDate!
    var updatedTime: NSDate!
    var isActive = false
    var idCardNumber: String = ""
    var phoneNumber: String = ""
    var name: String = ""
    var flightNumber: String = ""
    var carLicenseNumber: String = ""
    var tradeType: NSNumber!
    var bankType: String = ""
    var feeType: String = ""
    var startTime: NSDate!
    var totalFee: NSNumber!
    var quantity: NSNumber!
    var status: NSNumber!
    var buyerMessage: String = ""
    var remark: String = ""
    var agentId: NSNumber!
    var offerId: NSNumber!
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "id_str" : "idStr",
            "prepay_list" : "prepayList",
            "insurance_policies" : "insurancePolicies",
            "created_time" : "createdTime",
            "updated_time" : "updatedTime",
            "is_active" : "isActive",
            "id_card_number" : "idCardNumber",
            "phone_number" : "phoneNumber",
            "name" : "name",
            "flight_number" : "flightNumber",
            "car_license_number" : "carLicenseNumber",
            "trade_type" : "tradeType",
            "bank_type" : "bankType",
            "fee_type" : "feeType",
            "start_time" : "startTime",
            "total_fee" : "totalFee",
            "quantity" : "quantity",
            "status" : "status",
            "buyer_message" : "buyerMessage",
            "remark" : "remark",
            "agent_id" : "agentId",
            "offer_id" : "offerId",
        ]
    }
}
