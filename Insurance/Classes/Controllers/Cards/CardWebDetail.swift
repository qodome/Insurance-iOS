//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class CardWebDetail: WebDetail {
    var data: Card!
    
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "share")
    }
    
    // MARK: - 💛 Action
    func share() {
        startShareActivity(self, items: [data.caption, data.url], view: view)
    }
}
