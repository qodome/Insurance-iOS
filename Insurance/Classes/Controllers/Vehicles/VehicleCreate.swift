//
//  Copyright © 2015年 NY. All rights reserved.
//

class VehicleCreate: TextFieldCreate {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        mapping = getDetailMapping(Vehicle.self)
    }
}
