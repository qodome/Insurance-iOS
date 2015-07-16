//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class CardWebDetail: WebDetail {
    var data: Card!
    
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "share:")
    }
    
    // MARK: - 💛 Action
    func share(sender: AnyObject) {
        startShareActivity(self, [data.caption, data.url], view)
    }
}
