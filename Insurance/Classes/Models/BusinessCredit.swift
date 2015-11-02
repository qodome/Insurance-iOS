//
//  Copyright (c) 2015 NY. All rights reserved.
//

class BusinessCredit: ModelObject {
    var id: NSNumber!
    var agentId: NSNumber!
    var orderCount: NSNumber!
    var succCount: NSNumber!
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "agent_id" : "agentId",
            "order_count" : "orderCount",
            "succ_count" : "succCount",
        ]
    }
}
