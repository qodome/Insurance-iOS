//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class VehicleList: CollectionList {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        
    }
    
    override func onCreateLoader() -> BaseLoader? {
        return HttpLoader(endpoint: endpoint, type: User.self)
    }
}
