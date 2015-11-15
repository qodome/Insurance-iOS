//
//  Copyright © 2015年 NY. All rights reserved.
//

class OrderCell: UITableViewCell {
    var title = UILabel()
    var createdTime = UILabel()
    var totalFee = UILabel()
    var status = UILabel()
    
    // MARK: - 💖 生命周期 (Lifecycle)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        title.frame = CGRectMake(PADDING, PADDING / 3, frame.width - 2 * PADDING, 25)
        addSubview(title)
        status.frame = CGRectMake(PADDING, 30 + PADDING / 3, title.bounds.width / 2, 20)
        status.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        status.textColor = UIColor.colorWithHex(APP_COLOR).colorWithAlphaComponent(0.7)
        addSubview(status)
        totalFee.frame = CGRectMake(SCREEN_WIDTH - PADDING - status.bounds.width, status.frame.origin.y, status.bounds.width - 10, 20)
        totalFee.textAlignment = .Right
        totalFee.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        addSubview(totalFee)
        createdTime.frame = CGRectMake(PADDING, CGRectGetMaxY(totalFee.frame) + PADDING / 3, SCREEN_WIDTH - 2 * PADDING, 20)
        createdTime.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        createdTime.textColor = .grayColor()
        addSubview(createdTime)
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func setData(item: Order) {
        title.text = item.name
        createdTime.text = item.createdTime.formattedDateWithFormat("yyyy-MM-dd HH:mm:ss")
        totalFee.text = getFormatterPrice(item.totalFee)
        status.text = getStatusString(item.status)
        status.sizeToFit()
    }
}
