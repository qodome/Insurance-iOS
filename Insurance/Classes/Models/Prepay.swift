//
//  Copyright © 2015 NY. All rights reserved.
//

class Prepay: ModelObject {
    var id: NSNumber!
    var orderId: NSNumber!
    var mchId = ""
    var prepayId = ""
    var openId = ""
    var codeUrl = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "order_id" : "orderId",
            "mch_id" : "mchId",
            "prepay_id" : "prepayId",
            "open_id" : "openId",
            "code_url" : "codeUrl",
        ]
    }
}
