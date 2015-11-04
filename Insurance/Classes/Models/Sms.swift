//
//  Copyright © 2015年 NY. All rights reserved.
//

class Sms: ModelObject {
    var code: NSNumber!
    var result: NSNumber!
    var reason = ""

    override class func getMapping() -> [String : String] {
        return [
            "code" : "code",
            "reason" : "reason",
            "result" : "result",
        ]
    }
}
