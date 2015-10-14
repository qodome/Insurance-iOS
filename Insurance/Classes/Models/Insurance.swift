//
//  Copyright (c) 2015 NY. All rights reserved.
//

class Insurance: ModelObject {
    var clauses = ListModel() // 手动补
    var id: NSNumber!
    var imageUrls = ListModel()
    var createdTime: NSDate!
    var userId: NSNumber!
    var username: String = ""
    var userImageUrl: String = ""
    var isActive = false
    var skuId: NSNumber!
    var name: String = ""
    var companyId: NSNumber!
    var type: String = ""
    var price: NSNumber!
    var options: String = ""
    var desc: String = ""
    var imageUrl: String = ""
    var validityPeriod: NSNumber!
    
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
