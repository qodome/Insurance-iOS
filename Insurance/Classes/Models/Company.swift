//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Company: ModelObject {
    var id: NSNumber!
    var buyTel: NSString = ""
    var host: NSString = ""
    var insuranceCost: NSNumber!
    var goodCommentCount: NSNumber!
    var homePageUrl: NSString = ""
    var buyApiUrl: NSString = ""
    var companyName: NSString = ""
    var logo: NSString = ""
    var keepAlive: NSNumber!
    var insurance_type_list: [Insurance] = []
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "buy_tel" : "buyTel",
            "host" : "host",
            "insurance_cost" : "insuranceCost",
            "good_comment_count" : "goodCommentCount",
            "home_page_url" : "homePageUrl",
            "buy_api_url" : "buyApiUrl",
            "company_name" : "companyName",
            "logo" : "logo",
            "keep_alive" : "keepAlive",
        ]
    }
}
