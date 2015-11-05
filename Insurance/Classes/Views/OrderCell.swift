//
//  Copyright © 2015年 NY. All rights reserved.
//

class OrderCell: UITableViewCell {
    var orderTitle: UILabel!
    var orderTime: UILabel!
    var orderPrice: UILabel!
    var orderStatues: UILabel!
    
    // MARK: - 💖 生命周期 (Lifecycle)
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - 💜 UITableViewDelegate
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        orderTitle = UILabel(frame: CGRectMake(PADDING, PADDING / 3, frame.width - 2 * PADDING, 25))
        addSubview(orderTitle)
        orderStatues = UILabel(frame: CGRectMake(PADDING, 30 + PADDING / 3, orderTitle.bounds.width / 2, 20))
        orderStatues.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        orderStatues.textColor = .orangeColor()
        addSubview(orderStatues)
        orderPrice = UILabel(frame: CGRectMake(SCREEN_WIDTH - PADDING - orderStatues.bounds.width - 10, orderStatues.frame.origin.y, orderStatues.bounds.width - 10, 20))
        orderPrice.textAlignment = .Right
        orderPrice.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        addSubview(orderPrice)
        orderTime = UILabel(frame: CGRectMake(PADDING, orderPrice.frame.origin.y + orderPrice.bounds.height + PADDING / 3, SCREEN_WIDTH - 2 * PADDING, 20))
        orderTime.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        orderTime.textColor = .lightGrayColor()
        addSubview(orderTime)
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func setData(item: Order) {
        orderTitle.text = item.name
        orderTime.text = item.createdTime.formattedDateWithFormat("yyyy-MM-dd HH:mm:ss")
        orderPrice.text = getFormatterPrice(item.totalFee)
        orderStatues.text = getStatuesString(item.status)
        orderStatues.sizeToFit()
    }
}
