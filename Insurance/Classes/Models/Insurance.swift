//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Insurance: ModelObject {
    var id: NSNumber!
    var state: NSNumber!
    var isHot = false
    var options: NSString = ""
    var englishName: NSString = ""
    var type: NSNumber!
    var recommendSummary: NSString = ""
    var errorMsg: NSString = ""
    var insuranceName: NSString = ""
    var compensation = false
    var isToubao: NSString = ""
    var recommendDetail: NSString = ""
    var remark: NSString = ""
    var quotesPrice: NSString = ""
    var retCode: NSString = ""
    var price: NSNumber!
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "state" : "state",
            "is_hot" : "isHot",
            "options" : "options",
            "english_name" : "englishName",
            "type" : "type",
            "recommend_summary" : "recommendSummary",
            "error_msg" : "errorMsg",
            "insurance_name" : "insuranceName",
            "compensation" : "compensation",
            "is_toubao" : "isToubao",
            "recommend_detail" : "recommendDetail",
            "remark" : "remark",
            "quotes_price" : "quotesPrice",
            "ret_code" : "retCode",
            "price" : "price",
        ]
    }
}
