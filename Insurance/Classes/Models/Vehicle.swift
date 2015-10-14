//
//  Copyright (c) 2015 NY. All rights reserved.
//

class Vehicle: ModelObject {
    var id: NSNumber!
    var user: User?
    var city = ""
    var brand = ""
    var createdTime: NSDate!
    var updatedTime: NSDate!
    var isActive = false
    var imageUrl = ""
    var imageUrls = ListModel()
    var model = ""
    var carLicense = ""
    var ownerName = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "city" : "city",
            "brand" : "brand",
            "created_time" : "createdTime",
            "updated_time" : "updatedTime",
            "is_active" : "isActive",
            "image_url" : "imageUrl",
            "model" : "model",
            "car_license" : "carLicense",
            "owner_name" : "ownerName",
        ]
    }
}
