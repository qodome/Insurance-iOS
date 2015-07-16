//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Product: ModelObject {
    var insurances = ListModel()
    var id: NSNumber!
    var user: User?
    var createdTime: NSDate!
    var name: NSString = ""
    var price: NSNumber!
    var desc: NSString = ""
    var state: NSNumber!
    var imageUrl: NSString = ""
    var type: NSString = ""
    var isOpen: NSString = ""
    var sellNumber: NSNumber!
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "created_time" : "createdTime",
            "name" : "name",
            "price" : "price",
            "desc" : "desc",
            "state" : "state",
            "image_url" : "imageUrl",
            "type" : "type",
            "is_open" : "isOpen",
            "sell_number" : "sellNumber"
        ]
    }
}
