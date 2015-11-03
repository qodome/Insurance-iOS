//
//  Copyright © 2015年 NY. All rights reserved.
//

class OfferListCell: UITableViewCell {
    var thirdLabel = UILabel()
    var logoImage: ImageView!
    var moneyLabel: UILabel!
    var titleLabel = UILabel()
    var remarkImage: ImageView!
    var discountLabel = UILabel()
    var detailLabel = UILabel()
    let tagView = JxxTagsView()
    
    // MARK: - 💖 初始化
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - 💜 UITableViewDelegate
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        logoImage = ImageView(frame: CGRectMake(PADDING, 5, 80, 40))
        logoImage.contentMode = .ScaleAspectFit
        addSubview(logoImage)
        titleLabel.frame = CGRectMake(PADDING, 50, 0, 0)
        titleLabel.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        addSubview(titleLabel)
        moneyLabel = UILabel(frame: CGRectMake(frame.width - 100 - 2 * PADDING, 0, 100, 0))
        moneyLabel.textColor = .colorWithHex(APP_COLOR)
        moneyLabel.textAlignment = .Right
        addSubview(moneyLabel)
        thirdLabel.frame = CGRectMake(0, moneyLabel.frame.origin.y, 0, 0)
        thirdLabel.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        addSubview(thirdLabel)
        discountLabel.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        discountLabel.text = "7.1折"
        discountLabel.frame = CGRectMake(SCREEN_WIDTH - PADDING - 35, 50, 35, 20)
        addSubview(discountLabel)
        remarkImage = ImageView(frame: CGRectMake(discountLabel.frame.origin.x - 12, discountLabel.frame.origin.y + (discountLabel.bounds.height - 10) / 2, 10, 10))
        remarkImage.backgroundColor = UIColor.redColor()
        remarkImage.contentMode = .ScaleAspectFit
        addSubview(remarkImage)
        detailLabel.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        addSubview(detailLabel)
        addSubview(tagView)
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func setData(data: Offer) {
        logoImage.sd_setImageWithURL(NSURL(string: data.brand.image_url), placeholderImage: UIImage(named: "logo_brand_2.png"))
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        moneyLabel.text = "\(formatter.stringFromNumber(NSNumber(double: data.quotedPrice.doubleValue))!)"
        moneyLabel.sizeToFit()
        moneyLabel.frame.origin = CGPointMake(SCREEN_WIDTH - moneyLabel.bounds.width - PADDING, (50 - moneyLabel.bounds.height) / 2)
        if data.thirdParty != 0 {
            let string = NSMutableAttributedString(string: "\(data.thirdParty.integerValue / 10000)万三者")
            string.addAttributes([NSForegroundColorAttributeName : UIColor.colorWithHex(APP_COLOR)], range: NSMakeRange(0, string.length - 3))
            thirdLabel.attributedText = string
            thirdLabel.sizeToFit()
            thirdLabel.frame.origin = CGPoint(x: SCREEN_WIDTH - 2 * PADDING_INNER - moneyLabel.frame.width - thirdLabel.frame.width, y: moneyLabel.frame.origin.y + (moneyLabel.frame.height - thirdLabel.frame.height) / 2)
        }
        titleLabel.text = data.agent.name
        titleLabel.sizeToFit()
        remarkImage.hidden = data.remark == ""
        let deatilFormatter =  NSNumberFormatter()
        deatilFormatter.numberStyle = .PercentStyle
        let precentString = "\(deatilFormatter.stringFromNumber(NSNumber(double: (data.agent.credit?.succCount.doubleValue)!/(data.agent.credit?.orderCount.doubleValue)!))!)"
        let string = NSMutableAttributedString(string: "\(data.agent.credit!.orderCount)单 成功率\(precentString)")
        string.addAttributes([NSForegroundColorAttributeName : UIColor.colorWithHex(APP_COLOR)], range: NSMakeRange(0, "\(data.agent.credit!.orderCount)".length))
        string.addAttributes([NSForegroundColorAttributeName : UIColor.colorWithHex(APP_COLOR)], range: NSMakeRange(string.length - precentString.length, precentString.length))
        detailLabel.attributedText = string
        detailLabel.sizeToFit()
        detailLabel.frame.origin = CGPointMake(PADDING, titleLabel.bounds.height + titleLabel.frame.origin.y + 10)
        var tagsArray: [String] = []
        for (_, valueTag) in data.agent.tags.results.enumerate() {
            tagsArray += [valueTag.name]
        }
        tagView.frame = CGRectMake(2 * PADDING + detailLabel.bounds.width, discountLabel.frame.origin.y + discountLabel.bounds.height , SCREEN_WIDTH - 3 * PADDING - detailLabel.bounds.width, 23)
        for view in tagView.subviews {
            view.removeFromSuperview()
        }
        tagView.theme = TagsTheme(color: XIAOMAR_BLUE)
        tagView.setTags(tagsArray, target: nil, action: nil)
        LOG(tagView.getWidth())
        tagView.frame.origin.x = SCREEN_WIDTH - PADDING - tagView.getWidth()
    }
}
