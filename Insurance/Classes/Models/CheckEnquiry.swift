//
//  Copyright © 2015年 NY. All rights reserved.
//

class CheckEnquiry: ModelObject {
    var message = ""
    var status: NSNumber!
    var enquiryId: NSNumber!
    var orderId: NSNumber!
    
    override class func getMapping() -> [String : String] {
        return [
            "message" : "message",
            "enquiry_id" : "enquiryId",
            "order_id" : "orderId",
            "status" : "status",
        ]
    }
}
