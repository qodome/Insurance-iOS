//
//  Copyright © 2015年 NY. All rights reserved.
//

class EnquiryWatting: GroupedTableDetail, UIAlertViewDelegate {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        mapping = smartMapping(Enquiry.self)
        tableView.backgroundColor = .whiteColor()
        let imageView = ImageView(frame: CGRectMake(SCREEN_WIDTH / 6, SCREEN_WIDTH / 6, SCREEN_WIDTH / 3 * 2, SCREEN_WIDTH / 3 * 2), cornerRadius: SCREEN_WIDTH / 3)
        imageView.image = UIImage(named: endpoint.containsString("orders") ? "ic_order.png" : "ic_wait.png")
        tableView.addSubview(imageView)
        let button = getButton(CGRectMake((SCREEN_WIDTH - 160) / 2, view.frame.height - 49 - PADDING - BUTTON_HEIGHT - 64, 160, BUTTON_HEIGHT), title: endpoint.containsString("orders") ? LocalizedString("查看详情") : LocalizedString("取消询价"), theme: Theme(type: .Light, color: endpoint.containsString("orders") ? APP_COLOR : 0xB2B2B1))
        button.addTarget(self, action: "cancle", forControlEvents: .TouchUpInside)
        tableView.addSubview(button)
        let detailLabel = UILabel(frame: CGRectMake(PADDING, 0, SCREEN_WIDTH - 2 * PADDING, 0))
        detailLabel.text = endpoint.containsString("orders") ? "订单进行中，请尽快完成交易" : "保险公司正在为您报价，请稍后查看"
        detailLabel.sizeToFit()
        detailLabel.center = CGPointMake(SCREEN_WIDTH / 2, button.frame.origin.y - 2 * PADDING - detailLabel.frame.height / 2)
        tableView.addSubview(detailLabel)
    }

    override func onLoadSuccess<E : CheckEnquiry>(entity: E) {
        super.onLoadSuccess(entity)
        NSNotificationCenter.defaultCenter().postNotificationName("changeIndex", object: ["id" : "", "index" : "0"])
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func cancle() {
        if endpoint.containsString("orders") {
            let dest = OrderDetail()
            dest.endpoint = endpoint
            dest.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(dest, animated: true)
        } else {
            let alert = UIAlertController(title: "您确定要取消询价吗", message: nil, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "否", style: .Default, handler: nil))
            alert.addAction(UIAlertAction(title: "是", style: .Default, handler: { action in
                self.loader?.update(parameters: ["status" : "c"])
            }))
            presentViewController(alert, animated: true, completion: nil)
        }
    }
}
