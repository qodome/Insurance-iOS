//
//  Copyright © 2015年 NY. All rights reserved.
//

class OrderCreate: CreateController {
    
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        endpoint = getEndpoint("orders")
        // 不解析Product的话，生成订单取消支付再提交会导致product是nil而报错
        mapping = getDetailMapping(Order.self, children: [RKChild(path: "product", type: Product.self)])
        items = [
            [
                Item(title: "name"),
                Item(title: "total_fee")
            ],
            [
                Item(title: "phone_number"),
                Item(title: "flight_num"),
                Item(title: "start_time"),
                Item(title: "end_time"),
                Item(title: "departure_time")
            ]
        ]
        let button = QuickButton(frame: CGRectMake(0, view.frame.height - BUTTON_HEIGHT, view.frame.width, BUTTON_HEIGHT))
        button.addTarget(self, action: "create", forControlEvents: .TouchUpInside)
        button.setTitle(LocalizedString("confirm"), forState: .Normal)
        view.addSubview(button)
    }
    
    override func onCreateParameters<T : Order>(data: T?) -> [String : AnyObject]? {
        return [
            "product_id" : data!.product!.id
        ]
    }
    
    override func onLoadSuccess<E : Order>(entity: E) {
        super.onLoadSuccess(entity)
        // TODO: 防止重复下单
        checkout(entity)
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
    
    func checkout(order: Order) { // 支付
        // TODO: 如果没有APP对应的预支付单号，就申请预支付单号，获取成功就通知服务器，有的话，直接再支付
        let parameters = [
            "appid" : WX_APP_ID,
            "mch_id" : WX_MCH_ID,
            "device_info" : "iOS",
            "nonce_str" : "\(rand())",
            "trade_type" : "APP",
            "body" : order.name,
            "notify_url" : WX_NOTIFY_URL,
            "out_trade_no" : "\(order.id)",
            "total_fee" : "\(order.totalFee)",
            "spbill_create_ip": "192.168.1.1"
        ]
        if let prepayId = generatePrepay(parameters) { // 获得预支付订单号
            var parameters = [
                "appid" : WX_APP_ID,
                "partnerid" : WX_MCH_ID,
                "package" : "Sign=WXPay",
                "prepayid" : "\(prepayId)",
                "noncestr" : "\(Int(NSDate().timeIntervalSince1970))",
                "timestamp" : "\(Int(NSDate().timeIntervalSince1970))"
            ]
            parameters["sign"] = generateMD5Sign(parameters)
            let request = PayReq()
            request.openID = parameters["appid"]
            request.partnerId = parameters["partnerid"]
            request.prepayId = parameters["prepayid"]
            request.nonceStr = parameters["noncestr"]
            request.timeStamp = UInt32(Int(parameters["timestamp"]!)!)
            request.package = parameters["package"]
            request.sign = parameters["sign"]
            WXApi.sendReq(request)
        } else {
            showAlert(self, title: "prepayId error")
        }
    }
}
