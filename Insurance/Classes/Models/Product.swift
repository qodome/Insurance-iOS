//
//  Copyright (c) 2015 NY. All rights reserved.
//

class Product: ModelObject {
    var insurances = ListModel()
    var coupons = ListModel()
    var id: NSNumber!
    var user: User?
    var createdTime: NSDate!
    var isActive = false
    var name: String = ""
    var price: NSNumber!
    var desc: String = ""
    var imageUrl: String = ""
    var imageUrls = ListModel()
    var type: String = ""
    var isSplit: NSNumber!
    var inventory: NSNumber!
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "created_time" : "createdTime",
            "is_active" : "isActive",
            "name" : "name",
            "price" : "price",
            "description" : "desc",
            "image_url" : "imageUrl",
            "type" : "type",
            "is_split" : "isSplit",
            "inventory" : "inventory",
        ]
    }
}
