//
//  Copyright (c) 2015 NY. All rights reserved.
//

class Vehicle: ModelObject {
    var id: NSNumber!
    var user: User?
    var city: String = ""
    var brand: String = ""
    var createdTime: NSDate!
    var updatedTime: NSDate!
    var isActive = false
    var imageUrl: String = ""
    var imageUrls = ListModel()
    var model: String = ""
    var carLicense: String = ""
    var ownerName: String = ""
    
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
