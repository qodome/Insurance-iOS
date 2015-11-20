//
//  Copyright © 2015年 NY. All rights reserved.
//

class EnquiryWaiting: GroupedTableDetail, UIAlertViewDelegate {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        mapping = getDetailMapping(Enquiry.self)
        tableView.backgroundColor = .whiteColor()
        let imageView = ImageView(frame: CGRectMake(view.frame.width / 6, view.frame.width / 6, view.frame.width / 3 * 2, view.frame.width / 3 * 2), cornerRadius: view.frame.width / 3)
        imageView.image = UIImage(named: endpoint.containsString("orders") ? "ic_order.png" : "ic_wait.png")
        tableView.addSubview(imageView)
        let button = QuickButton(frame: CGRectMake((view.frame.width - 160) / 2, view.frame.height - TAB_BAR_HEIGHT - 2 * PADDING - BUTTON_HEIGHT - 64, 160, BUTTON_HEIGHT), title: endpoint.containsString("orders") ? LocalizedString("查看详情") : LocalizedString("取消询价"), theme: Theme(style: .Light, color: endpoint.containsString("orders") ? APP_COLOR : 0xB2B2B1))
        button.addTarget(self, action: "cancle", forControlEvents: .TouchUpInside)
        tableView.addSubview(button)
        let detailLabel = UILabel(frame: CGRectMake(PADDING, 0, view.frame.width - 2 * PADDING, 0))
        detailLabel.text = endpoint.containsString("orders") ? "订单有效期 72 小时，保险机构将尽快与您联系并完成投保，请保持手机畅通" : "询价发起时间 \(getString("created_time"))，保险机构正为您报价，请在发起时间2小时后查看报价"
        detailLabel.numberOfLines = 0
        detailLabel.textAlignment = .Center
        detailLabel.sizeToFit()
        detailLabel.center = CGPointMake(view.frame.width / 2, button.frame.origin.y - 2 * PADDING - detailLabel.frame.height / 2)
        tableView.addSubview(detailLabel)
    }
    
    override func onLoadSuccess<E : Enquiry>(entity: E) {
        super.onLoadSuccess(entity)
        NSNotificationCenter.defaultCenter().postNotificationName("changeIndex", object: ["id" : 0, "index" : "0"])
    }
    
    override func onSegue(segue: UIStoryboardSegue?, dest: UIViewController, id: String) {
        dest.setValue(endpoint, forKey: "endpoint")
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func cancle() {
        if endpoint.containsString("orders") {
            startActivity(Item(dest: OrderDetail.self, storyboard: false))
        } else {
            showAlert(self, message: LocalizedString("确认取消询价吗？"), action: UIAlertAction(title: LocalizedString("是"), style: .Default, handler: { action in
                self.loader?.update(parameters: ["status" : "c"])
            }), cancelButtonTitle: LocalizedString("否"))
        }
    }
}
