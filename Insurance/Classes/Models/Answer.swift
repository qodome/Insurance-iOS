//
//  Copyright (c) 2014 NY. All rights reserved.
//

class Answer: BaseModel {
    var id: NSNumber!
    var user: User?
    var createdTime: NSDate!
    var isActive = false
    var questionId: NSNumber!
    var text: NSString = ""
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
