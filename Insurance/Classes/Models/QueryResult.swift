//
//  Copyright (c) 2014 NY. All rights reserved.
//

class QueryResult: BaseModel {
    var insuranceQueryTime: NSNumber!
    var insuranceStartDate: NSDate!
    var errorMsg: NSString = ""
    var totalPrice: NSString = ""
    var status: NSNumber!
    var refererId: NSString = ""
    var company_info: Company!
    
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
