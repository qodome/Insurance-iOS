//
//  Copyright © 2015 NY. All rights reserved.
//

class QueryResult: ModelObject {
    var insuranceQueryTime: NSNumber!
    var insuranceStartDate: NSDate!
    var errorMsg = ""
    var totalPrice: NSNumber!
    var status: NSNumber!
    var refererId = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "insurance_query_time" : "insuranceQueryTime",
            "insurance_start_date" : "insuranceStartDate",
            "error_msg" : "errorMsg",
            "total_price" : "totalPrice",
            "status" : "status",
            "referer_id" : "refererId",
        ]
    }
}
