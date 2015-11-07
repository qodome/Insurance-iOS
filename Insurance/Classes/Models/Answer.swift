//
//  Copyright © 2015 NY. All rights reserved.
//

class Answer: ModelObject {
    var id: NSNumber!
    var user: User?
    var createdTime: NSDate!
    var isActive = false
    var questionId: NSNumber!
    var text = ""
    var upvoteCount: NSNumber!
    var downvoteCount: NSNumber!
    
    override class func getMapping() -> [String : String] {
        return [
            "id" : "id",
            "created_time" : "createdTime",
            "is_active" : "isActive",
            "question_id" : "questionId",
            "text" : "text",
            "upvote_count" : "upvoteCount",
            "downvote_count" : "downvoteCount",
        ]
    }
}
