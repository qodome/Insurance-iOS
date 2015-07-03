//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Illegaality: BaseModel {
    var status: NSString = ""
    var uniqueCode: NSString = ""
    var excutelocation: NSString = ""
    var locationName: NSString = ""
    var latefine: NSString = ""
    var department: NSString = ""
    var dataSourceId: NSString = ""
    var count: NSString = ""
    var time: NSDate!
    var cityCode: NSString = ""
    var carNo: NSString = ""
    var reason: NSString = ""
    var carEngine: NSString = ""
    var locationid: NSString = ""
    var carCode: NSString = ""
    var canprocessMsg: NSString = ""
    
    override class func getMapping() -> [String : String] {
        return [
            "status" : "status",
            "unique_code" : "uniqueCode",
            "excutelocation" : "excutelocation",
            "location_name" : "locationName",
            "latefine" : "latefine",
            "department" : "department",
            "data_source_id" : "dataSourceId",
            "count" : "count",
            "time" : "time",
            "city_code" : "cityCode",
            "car_no" : "carNo",
            "reason" : "reason",
            "car_engine" : "carEngine",
            "locationid" : "locationid",
            "car_code" : "carCode",
            "canprocess_msg" : "canprocessMsg",
        ]
    }
}
