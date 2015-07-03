//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Order: BaseModel {
    var id: NSNumber!
    var createdTime: NSDate!
    var name: NSString = ""
    var type: NSString = ""
    var prepayId: NSString = ""
    var mchId: NSNumber!
    var openId: NSString = ""
    var price: NSNumber!
    var status: NSString = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "created_time" : "createdTime",
            "name" : "name",
            "type" : "type",
            "prepay_id" : "prepayId",
            "mch_id" : "mchId",
            "open_id" : "openId",
            "price" : "price",
            "status" : "status",
        ]
    }
}
