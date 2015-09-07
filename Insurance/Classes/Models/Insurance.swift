//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Insurance: ModelObject {
    var id: NSNumber!
    var createdTime: NSDate!
    var insuranceId: NSNumber!
    var name: NSString = ""
    var companyId: NSNumber!
    var type: NSString = ""
    var price: NSNumber!
    var options: NSString = ""
    var desc: NSString = ""
    var imageUrl: NSString = ""
    var expired: NSNumber!
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "created_time" : "createdTime",
            "insurance_id" : "insuranceId",
            "name" : "name",
            "company_id" : "companyId",
            "type" : "type",
            "price" : "price",
            "options" : "options",
            "description" : "desc",
            "image_url" : "imageUrl",
            "expired" : "expired",
        ]
    }
}
