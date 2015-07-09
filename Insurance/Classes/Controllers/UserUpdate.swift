//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class UserUpdate: TextFieldUpdate {
    // MARK: - 🐤 Taylor    
//    override func onCreateLoader() -> BaseLoader? {
//        endpoint = getEndpoint("users/\((data as! User).id)")
//        return HttpLoader(endpoint: endpoint, type: User.self)
//    }
    
    override func onUpdate(string: String) {
        (loader as? HttpLoader)?.patch(parameters: [fieldName : string])
    }
}
