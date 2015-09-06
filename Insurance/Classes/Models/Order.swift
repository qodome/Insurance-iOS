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
    var totalFee: NSNumber!
    var phoneNumber: NSString = ""
    var flightNum: NSString = ""
    var departureTime: NSDate!
    var startTime: NSDate!
    var endTime: NSDate!
    var tradeType: NSString = ""
    var prepayId: NSString = ""
    var mchId: NSString = ""
    var openId: NSString = ""
    var status: NSString = ""
    var isOpen: NSString = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "id_str" : "idStr",
            "created_time" : "createdTime",
            "name" : "name",
            "total_fee" : "totalFee",
            "phone_number" : "phoneNumber",
            "flight_num" : "flightNum",
            "departure_time" : "departureTime",
            "start_time" : "startTime",
            "end_time" : "endTime",
            "trade_type" : "tradeType",
            "prepay_id" : "prepayId",
            "mch_id" : "mchId",
            "open_id" : "openId",
            "status" : "status",
            "is_open" : "isOpen",
        ]
    }
}
