//
//  Copyright © 2015年 NY. All rights reserved.
//

class OfferDeatilHead: UITableViewCell {
    var mImage: ImageView!
    var moneyLabel = UILabel()
    var detailLabel = UILabel()
    
    // MARK: - 💖 初始化
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        mImage = ImageView(frame: CGRectMake(PADDING, 5, 80, 40))
        mImage.contentMode = .ScaleAspectFit
        addSubview(mImage)
        addSubview(moneyLabel)
        detailLabel.frame = CGRectMake(PADDING, 50, SCREEN_WIDTH - 2 * PADDING, 0)
        detailLabel.numberOfLines = 0
        detailLabel.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        addSubview(detailLabel)
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func setData(data: Offer) {
        moneyLabel.text = getFormatterPrice(data.quotedPrice)
        moneyLabel.sizeToFit()
        moneyLabel.frame.origin = CGPointMake(SCREEN_WIDTH - PADDING - moneyLabel.bounds.width, (50 - moneyLabel.bounds.height) / 2)
        moneyLabel.textColor = .darkGrayColor()
        mImage.sd_setImageWithURL(NSURL(string: data.brand.image_url), placeholderImage: UIImage(named: "logo_brand_2.png"))
        detailLabel.text = "\(data.remark)"
        detailLabel.sizeToFit()
    }
}
