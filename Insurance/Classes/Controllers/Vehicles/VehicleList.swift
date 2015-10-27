//
//  Copyright © 2015年 NY. All rights reserved.
//

class VehicleList: CollectionList {
    // MARK: - 🐤 Taylor
    override func onPrepare<T : UICollectionView>(listView: T) {
        super.onPrepare(listView)
        title = LocalizedString("vehicles")
        // if 判断是否出现添加按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "add")
    }
    
    override func onCreateLoader() -> BaseLoader? {
        return HttpLoader(endpoint: endpoint, type: Vehicle.self)
    }
    
    func add() {
        startActivity(Item(title: "vehicle_create", dest: VehicleCreate.self))
    }
}
