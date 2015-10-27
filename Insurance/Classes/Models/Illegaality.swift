//
//  Copyright © 2015 NY. All rights reserved.
//

class Illegaality: ModelObject {
    var status = ""
    var uniqueCode = ""
    var excutelocation = ""
    var locationName = ""
    var latefine = ""
    var department = ""
    var dataSourceId = ""
    var count = ""
    var time: NSDate!
    var cityCode = ""
    var carNo = ""
    var reason = ""
    var carEngine = ""
    var locationid = ""
    var carCode = ""
    var canprocessMsg = ""
    
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
