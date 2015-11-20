//
//  Copyright © 2015年 NY. All rights reserved.
//

class OfferListCell: UITableViewCell {
    let thirdParty = UILabel()
    var logoImage: ImageView!
    let quotedPrice = UILabel()
    let titleLabel = UILabel()
    var remarkImage: ImageView!
    let discountLabel = UILabel()
    let subtitle = UILabel()
    let tagsView = JxxTagsView()
    
    // MARK: - 💖 初始化
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        logoImage = ImageView(frame: CGRectMake(PADDING, 5, 80, 40))
        logoImage.contentMode = .ScaleAspectFit
        addSubview(logoImage)
        titleLabel.frame = CGRectMake(PADDING, 50, 0, 0)
        titleLabel.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        addSubview(titleLabel)
        quotedPrice.textColor = .colorWithHex(APP_COLOR)
        quotedPrice.textAlignment = .Right
        addSubview(quotedPrice)
        thirdParty.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        addSubview(thirdParty)
        discountLabel.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        discountLabel.frame = CGRectMake(SCREEN_WIDTH - PADDING - 35, 50, 35, 20)
        addSubview(discountLabel)
        remarkImage = ImageView(frame: CGRectMake(discountLabel.frame.origin.x - 22, 0, 17, 17))
        let remarkSettings =  FAKFontAwesome.giftIconWithSize(CGSizeSettingsIcon.width)
        remarkSettings.addAttribute(NSForegroundColorAttributeName, value: UIColor.colorWithHex(APP_COLOR))
        remarkImage.image = remarkSettings.imageWithSize(CGSizeSettingsIcon)
        remarkImage.contentMode = .ScaleAspectFit
        addSubview(remarkImage)
        subtitle.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        addSubview(subtitle)
        tagsView.theme = TagsTheme(color: XIAOMAR_BLUE)
        addSubview(tagsView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for view in tagsView.subviews {
            view.removeFromSuperview()
        }
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func setData(data: Offer) {
        logoImage.sd_setImageWithURL(NSURL(string: data.brand.image_url), placeholderImage: UIImage(named: "logo_brand_2.png"))
        quotedPrice.text = getFormatterPrice(data.quotedPrice)
        quotedPrice.sizeToFit()
        quotedPrice.frame.origin = CGPointMake(SCREEN_WIDTH - quotedPrice.bounds.width - PADDING, (50 - quotedPrice.bounds.height) / 2)
        if data.thirdParty != 0 {
            let string = NSMutableAttributedString(string: "\(data.thirdParty.integerValue / 10000)万三者")
            string.addAttributes([NSForegroundColorAttributeName : UIColor.colorWithHex(APP_COLOR)], range: NSMakeRange(0, string.length - 3))
            thirdParty.attributedText = string
            thirdParty.sizeToFit()
            thirdParty.frame.origin.x = SCREEN_WIDTH - 2 * PADDING_INNER - quotedPrice.frame.width - thirdParty.frame.width
            thirdParty.center.y = quotedPrice.center.y
        }
        titleLabel.text = data.agent.shortName
        titleLabel.sizeToFit()
        remarkImage.hidden = data.remark.isEmpty
        let discount = String(format: "%.1f", (data.quotedPrice.floatValue - data.motorTaxes.floatValue) / data.originalPrice.floatValue * 10)
        if Float(discount) < 7 {
            discountLabel.text = "7.0折"
        } else if Float(discount) >= 10 {
            discountLabel.text = ""
        } else {
            discountLabel.text = "\(discount)折"
        }
        if data.agent.credit!.orderCount != 0 {
            let deatilFormatter =  NSNumberFormatter()
            deatilFormatter.numberStyle = .PercentStyle
            let precentString = "\(deatilFormatter.stringFromNumber(NSNumber(double: (data.agent.credit?.succCount.doubleValue)!/(data.agent.credit?.orderCount.doubleValue)!))!)"
            let string = NSMutableAttributedString(string: "\(data.agent.credit!.orderCount)单 成功率\(precentString)")
            string.addAttributes([NSForegroundColorAttributeName : UIColor.colorWithHex(APP_COLOR)], range: NSMakeRange(0, "\(data.agent.credit!.orderCount)".length))
            string.addAttributes([NSForegroundColorAttributeName : UIColor.colorWithHex(APP_COLOR)], range: NSMakeRange(string.length - precentString.length, precentString.length))
            subtitle.attributedText = string
            
        } else {
            subtitle.text = "无成交"
        }
        discountLabel.center.y = titleLabel.center.y
        remarkImage.center.y = titleLabel.center.y
        subtitle.sizeToFit()
        subtitle.frame.origin = CGPointMake(PADDING, CGRectGetMaxY(titleLabel.frame) + 10)
        var tagsArray: [String] = []
        for tag in data.agent.tags.results as! [Tag] {
            tagsArray += [tag.name]
        }
        tagsView.frame = CGRectMake(2 * PADDING + subtitle.bounds.width, CGRectGetMaxY(discountLabel.frame) + 5, SCREEN_WIDTH - 2 * PADDING - subtitle.bounds.width, 23)
        tagsView.setTags(tagsArray, target: nil, action: nil)
        tagsView.frame.origin.x = SCREEN_WIDTH - PADDING - tagsView.getWidth()
    }
}
