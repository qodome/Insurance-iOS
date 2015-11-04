//
//  Copyright © 2015年 NY. All rights reserved.
//

class OfferDeatilCell: UITableViewCell {
    var title = UILabel()
    var detailLabel = UILabel()
    let tagView = JxxTagsView()
    
    // MARK: - 💖 初始化
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - 💜 UITableViewDelegate
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        title.frame = CGRectMake(PADDING, 5, SCREEN_WIDTH - 2 * PADDING, 20)
        addSubview(title)
        detailLabel.frame = CGRectMake(PADDING, 30, SCREEN_WIDTH - 2 * PADDING, 20)
        detailLabel.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        addSubview(detailLabel)
        tagView.frame = CGRectMake(0, 50, SCREEN_WIDTH, 28)
        addSubview(tagView)
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func setData(data: Offer) {
        title.text = data.agent.name
        if data.agent.credit!.orderCount != 0 {
            let formatter =  NSNumberFormatter()
            formatter.numberStyle = .PercentStyle
            let precentString = "\(formatter.stringFromNumber(NSNumber(double: (data.agent.credit?.succCount.doubleValue)!/(data.agent.credit?.orderCount.doubleValue)!))!)"
            let string = NSMutableAttributedString(string: "交易量\(data.agent.credit!.orderCount)单 成交率\(precentString)")
            string.addAttributes([NSForegroundColorAttributeName : UIColor.colorWithHex(APP_COLOR)], range: NSMakeRange(3, "\(data.agent.credit!.orderCount)".length))
            string.addAttributes([NSForegroundColorAttributeName : UIColor.colorWithHex(APP_COLOR)], range: NSMakeRange(string.length - precentString.length, precentString.length))
            detailLabel.attributedText = string
        }
        var tagsArray: [String] = []
        for (_, valueTag) in data.agent.tags.results.enumerate() {
            tagsArray += [valueTag.name]
        }
        tagView.theme = TagsTheme(color: XIAOMAR_BLUE)
        tagView.setTags(tagsArray, target: nil, action: nil)
    }
}
