//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Order: ModelObject {
    var user: User?
    var product: Product?
    var id: NSNumber!
    var idStr: NSString = ""
    var createdTime: NSDate!
    var name: NSString = ""
    var type: NSString = ""
    var prepayId: NSString = ""
    var mchId: NSString = ""
    var openId: NSString = ""
    var totalFee: NSNumber!
    var status: NSString = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "id_str" : "idStr",
            "created_time" : "createdTime",
            "name" : "name",
            "type" : "type",
            "prepay_id" : "prepayId",
            "mch_id" : "mchId",
            "open_id" : "openId",
            "total_fee" : "totalFee",
            "status" : "status",
        ]
    }
}
