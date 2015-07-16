//
//  Copyright (c) 2014 NY. All rights reserved.
//

class SubOrder: ModelObject {
    var id: NSNumber!
    var good: NSString = ""
    var createdTime: NSDate!
    var name: NSString = ""
    var productId: NSNumber!
    var totalFee: NSNumber!
    var phoneNumber: NSString = ""
    var flightNum: NSString = ""
    var departureTime: NSDate!
    var startTime: NSDate!
    var endTime: NSDate!
    var parentOrderId: NSNumber!
    var goodId: NSNumber!
    var status: NSString = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "good" : "good",
            "created_time" : "createdTime",
            "name" : "name",
            "product_id" : "productId",
            "total_fee" : "totalFee",
            "phone_number" : "phoneNumber",
            "flight_num" : "flightNum",
            "departure_time" : "departureTime",
            "start_time" : "startTime",
            "end_time" : "endTime",
            "parent_order_id" : "parentOrderId",
            "good_id" : "goodId",
            "status" : "status",
        ]
    }
}
