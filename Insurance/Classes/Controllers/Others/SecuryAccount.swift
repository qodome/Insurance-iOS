//
//  Copyright © 2015年 NY. All rights reserved.
//

class SecuryAccount: GroupedTableDetail {
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [
            [Item(title: "securyupdate", dest: SecuryUpdate.self, storyboard: false)],
        ]
    }
}
