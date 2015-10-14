//
//  Copyright (c) 2015 NY. All rights reserved.
//

class Illegaality: ModelObject {
    var status: String = ""
    var uniqueCode: String = ""
    var excutelocation: String = ""
    var locationName: String = ""
    var latefine: String = ""
    var department: String = ""
    var dataSourceId: String = ""
    var count: String = ""
    var time: NSDate!
    var cityCode: String = ""
    var carNo: String = ""
    var reason: String = ""
    var carEngine: String = ""
    var locationid: String = ""
    var carCode: String = ""
    var canprocessMsg: String = ""
    
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
