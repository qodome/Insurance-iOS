//
//  Copyright © 2015年 NY. All rights reserved.
//

class OfferDeatilHead: UITableViewCell {
    var title = UILabel()
    var mImage: ImageView!
    var moneyLabel = UILabel()
    var detailLabel = UILabel()
    
    // MARK: - 💖 初始化
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - 💜 UITableViewDelegate
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        mImage = ImageView(frame: CGRectMake(PADDING, 5, 80, 40))
        mImage.contentMode = .ScaleAspectFit
        addSubview(mImage)
        addSubview(title)
        addSubview(moneyLabel)
        detailLabel.frame = CGRectMake(PADDING, 50, SCREEN_WIDTH - 2 * PADDING, 0)
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont.systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        addSubview(detailLabel)
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func setData(data: Offer) {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        moneyLabel.text = "\(formatter.stringFromNumber(NSNumber(double: data.quotedPrice.doubleValue))!)"
        moneyLabel.sizeToFit()
        moneyLabel.frame.origin = CGPointMake(SCREEN_WIDTH - PADDING - moneyLabel.bounds.width, (50 - moneyLabel.bounds.height) / 2)
        moneyLabel.textColor = .darkGrayColor()
        title.text = data.brand.name
        title.frame = CGRectMake(1.5 * PADDING + 80, moneyLabel.frame.origin.y, SCREEN_WIDTH - (3.5 * PADDING + 80 + moneyLabel.bounds.width), moneyLabel.bounds.height)
        mImage.sd_setImageWithURL(NSURL(string: data.brand.image_url), placeholderImage: UIImage(named: "logo_brand_2.png"))
        detailLabel.text = "\(data.remark)"
        detailLabel.sizeToFit()
    }
}
