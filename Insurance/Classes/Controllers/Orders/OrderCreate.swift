//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class OrderCreate: CreateController {
    
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        endpoint = getEndpoint("orders")
        items = [
            [Item(title: "total_fee")
            ],
            [Item(title: "price")
            ]
        ]
        let button = QuickButton(frame: CGRectMake(0, view.frame.height - 44, view.frame.width, 44))
        button.addTarget(self, action: "create:", forControlEvents: .TouchUpInside)
        button.setTitle(LocalizedString("confirm"), forState: .Normal)
        view.addSubview(button)
    }
    
    override func onCreateLoader() -> BaseLoader? {
        // 不解析Product的话，生成订单取消支付再提交会导致product是nil而报错
        let mapping = smartMapping(Order.self, children: ["product" : Product.self])
        return HttpLoader(endpoint: endpoint, mapping: mapping)
    }
    
    override func onCreateParameters<T : Order>(data: T?) -> [String : AnyObject]? {
        return [
            "product_id" : data!.product!.id
        ]
    }
    
    override func onLoadSuccess<E : Order>(entity: E) {
        super.onLoadSuccess(entity)
        checkout()
    }
    
    override func getItemView<T : Order, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        switch item.title {
        case "total_fee":
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            cell.detailTextLabel?.text = formatter.stringFromNumber(NSNumber(double: data.totalFee.doubleValue / 100))
        default: break
        }
        return cell
    }
    
    func checkout() { // 支付
        // TODO: 如果没有APP对应的预支付单号，就申请预支付单号，获取成功就通知服务器，有的话，直接再支付
        let parameters = [
            "appid" : WX_APP_ID,
            "mch_id" : WX_MCH_ID,
            "device_info" : "APP-001",
            "nonce_str" : "\(rand())",
            "trade_type" : "APP",
            "body" : data == nil ? "" : (data as! Order).name as String,
            "notify_url" : WX_NOTIFY_URL,
            "out_trade_no" : "\(Int(NSDate().timeIntervalSince1970))",
            "total_fee" : data == nil ? "0" : "\((data as! Order).totalFee)",
            "spbill_create_ip": "192.168.1.1"
        ]
        let prepayId = generatePrepay(parameters) // 获得预支付订单号
        if prepayId != nil {
            var parameters = [
                "appid" : WX_APP_ID,
                "partnerid" : WX_MCH_ID,
                "package" : "Sign=WXPay",
                "prepayid" : "\(prepayId!)",
                "noncestr" : "\(Int(NSDate().timeIntervalSince1970))",
                "timestamp" : "\(Int(NSDate().timeIntervalSince1970))"
            ]
            parameters["sign"] = generateMD5Sign(parameters)
            let request = PayReq()
            request.openID = parameters["appid"]
            request.partnerId = parameters["partnerid"]
            request.prepayId = parameters["prepayid"]
            request.nonceStr = parameters["noncestr"]
            request.timeStamp = UInt32(parameters["timestamp"]!.toInt()!)
            request.package = parameters["package"]
            request.sign = parameters["sign"]
            WXApi.sendReq(request)
        }
    }
}
