//
//  Copyright © 2015 NY. All rights reserved.
//

class ClaimRecord: ModelObject {
    var id: NSNumber!
    var createdTime: NSDate!
    var userId: NSNumber!
    var username = ""
    var userImageUrl = ""
    var isActive = false
    var idCardNumber = ""
    var phoneNumber = ""
    var insurancePolicyId: NSNumber!
    var claimAmount: NSNumber!
    var content = ""
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
