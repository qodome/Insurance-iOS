//
//  Copyright (c) 2014 NY. All rights reserved.
//

class QueryResult: ModelObject {
    var company_info: Company?
    var insuranceQueryTime: NSNumber!
    var insuranceStartDate: NSDate!
    var errorMsg: NSString = ""
    var totalPrice: NSString = ""
    var status: NSNumber!
    var refererId: NSString = ""
    
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
