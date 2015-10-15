//
//  Copyright (c) 2015 NY. All rights reserved.
//

class Insurance: ModelObject {
    var id: NSNumber!
    var imageUrls = ListModel()
    var createdTime: NSDate!
    var userId: NSNumber!
    var username = ""
    var userImageUrl = ""
    var isActive = false
    var skuId: NSNumber!
    var name = ""
    var companyId: NSNumber!
    var type = ""
    var price: NSNumber!
    var options = ""
    var desc = ""
    var imageUrl = ""
    var validityPeriod: NSNumber!
    var clauses = ListModel()
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "created_time" : "createdTime",
            "user_id" : "userId",
            "username" : "username",
            "user_image_url" : "userImageUrl",
            "is_active" : "isActive",
            "sku_id" : "skuId",
            "name" : "name",
            "company_id" : "companyId",
            "type" : "type",
            "price" : "price",
            "options" : "options",
            "description" : "desc",
            "image_url" : "imageUrl",
            "validity_period" : "validityPeriod",
        ]
    }
}
