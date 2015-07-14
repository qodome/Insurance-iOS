//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Product: ModelObject {
    var id: NSNumber!
    var createdTime: NSDate!
    var name: NSString = ""
    var price: NSNumber!
    var standardPrice: NSNumber!
    var desc: NSString = ""
    var imageUrl: NSString = ""
    var saleNum: NSNumber!
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "created_time" : "createdTime",
            "name" : "name",
            "price" : "price",
            "standard_price" : "standardPrice",
            "desc" : "desc",
            "image_url" : "imageUrl",
            "sale_num" : "saleNum",
        ]
    }
}
