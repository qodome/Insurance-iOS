//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class VehicleList: CollectionList {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        title = LocalizedString("vehicles")
        // if 判断是否出现添加按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "add:")
    }
    
    override func onCreateLoader() -> BaseLoader? {
        return HttpLoader(endpoint: endpoint, type: Vehicle.self)
    }
    
    func add(sender: AnyObject) {
        startActivity(Item(title: "vehicle_create", dest: VehicleCreate.self))
    }
}
