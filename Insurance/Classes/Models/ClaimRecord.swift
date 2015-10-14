//
//  Copyright (c) 2015 NY. All rights reserved.
//

class ClaimRecord: ModelObject {
    var id: NSNumber!
    var createdTime: NSDate!
    var userId: NSNumber!
    var username: String = ""
    var userImageUrl: String = ""
    var isActive = false
    var idCardNumber: String = ""
    var phoneNumber: String = ""
    var insurancePolicyId: NSNumber!
    var claimAmount: NSNumber!
    var content: String = ""
    var status: NSNumber!
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "created_time" : "createdTime",
            "user_id" : "userId",
            "username" : "username",
            "user_image_url" : "userImageUrl",
            "is_active" : "isActive",
            "id_card_number" : "idCardNumber",
            "phone_number" : "phoneNumber",
            "insurance_policy_id" : "insurancePolicyId",
            "claim_amount" : "claimAmount",
            "content" : "content",
            "status" : "status",
        ]
    }
}
