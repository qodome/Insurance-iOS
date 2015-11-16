//
//  Copyright © 2015年 NY. All rights reserved.
//

class OfferDeatilHead: UITableViewCell {
    var logoImage: ImageView!
    var quotedPrice = UILabel()
    var remark = UILabel()
    
    // MARK: - 💖 初始化
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        logoImage = ImageView(frame: CGRectMake(PADDING, 5, 80, 40))
        logoImage.contentMode = .ScaleAspectFit
        addSubview(logoImage)
        addSubview(quotedPrice)
        remark.frame = CGRectMake(PADDING, 50, SCREEN_WIDTH - 2 * PADDING, 0)
        remark.numberOfLines = 0
        remark.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        addSubview(remark)
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func setData(data: Offer) {
        quotedPrice.text = getFormatterPrice(data.quotedPrice)
        quotedPrice.sizeToFit()
        quotedPrice.frame.origin = CGPointMake(SCREEN_WIDTH - PADDING - quotedPrice.bounds.width, (50 - quotedPrice.bounds.height) / 2)
        quotedPrice.textColor = .darkGrayColor()
        logoImage.sd_setImageWithURL(NSURL(string: data.brand.image_url), placeholderImage: UIImage(named: "logo_brand_2.png"))
        remark.text = "\(data.remark)"
        remark.sizeToFit()
    }
}
