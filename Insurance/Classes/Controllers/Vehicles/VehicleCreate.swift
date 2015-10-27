//
//  Copyright © 2015年 NY. All rights reserved.
//

class VehicleCreate: TextFieldCreate {
    // MARK: - 🐤 Taylor
    override func onCreateLoader() -> BaseLoader? {
        return HttpLoader(endpoint: endpoint, type: Vehicle.self)
    }
}
