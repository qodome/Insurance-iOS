//
//  Copyright © 2015年 NY. All rights reserved.
//

class EnquiryWatting: TableDetail, UIAlertViewDelegate {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [[Item.emptyItem()], [Item.emptyItem()]]
    }
    
    override func onCreateLoader() -> BaseLoader? {
        let mapping = smartMapping(Enquiry.self)
        return HttpLoader(endpoint: endpoint, mapping: mapping)
    }
    
    override func onLoadSuccess<E : CheckEnquiry>(entity: E) {
        super.onLoadSuccess(entity)
        NSNotificationCenter.defaultCenter().postNotificationName("changeIndex", object: ["id" : "", "index" : "0"])
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        if indexPath.section == 0 {
            cell.contentView.addSubview(returnLabel())
        } else {
            let button = QuickButton(frame: CGRect(origin: cell.frame.origin, size: CGSizeMake(SCREEN_WIDTH, cell.bounds.height)))
            button.backgroundColor = endpoint.containsString("orders") ? UIColor.colorWithHex(APP_COLOR).colorWithAlphaComponent(0.7) : .lightGrayColor()
            button.addTarget(self, action: "cancle", forControlEvents: .TouchUpInside)
            button.setTitle(endpoint.containsString("orders") ? LocalizedString("查看详情") : LocalizedString("取消询价"), forState: .Normal)
            cell.contentView.addSubview(button)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.section == 0 ? returnLabel().bounds.height + 2 * PADDING : tableView.rowHeight
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
            alert.addAction(UIAlertAction(title: "是", style: .Default, handler: { (action) in
                (self.loader as! HttpLoader).patch(parameters: ["status" : "c"])
            }))
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func returnLabel() -> UILabel {
        let detailLabel = UILabel(frame: CGRectMake(PADDING, PADDING, SCREEN_WIDTH - 2 * PADDING, 0))
        detailLabel.lineBreakMode = .ByCharWrapping
        detailLabel.numberOfLines = 0
        detailLabel.text = endpoint.containsString("orders") ? "您当前有一个车险订单正在生成中。我们会和您线下联系，商讨购买车险的具体事宜。请保持通讯畅通，谢谢。" : "您当前已经发起了一个车险询价，我们正在为您准备报价，请耐心等待。稍后您可以到此界面查看最终的报价结果。谢谢"
        detailLabel.sizeToFit()
        return detailLabel
    }
}
