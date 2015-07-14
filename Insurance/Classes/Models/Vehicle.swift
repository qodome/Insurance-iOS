//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class Vehicle: ModelObject {
    var id: NSNumber!
    var user: User?
    var city: NSString = ""
    var brand: NSString = ""
    var createdTime: NSDate!
    var updatedTime: NSDate!
    var imageUrl: NSString = ""
    var model: NSString = ""
    var carLicense: NSString = ""
    var ownerName: NSString = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "city" : "city",
            "brand" : "brand",
            "created_time" : "createdTime",
            "updated_time" : "updatedTime",
            "image_url" : "imageUrl",
            "model" : "model",
            "car_license" : "carLicense",
            "owner_name" : "ownerName",
        ]
    }
}
