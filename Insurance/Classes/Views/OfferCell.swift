//
//  Copyright © 2015年 NY. All rights reserved.
//

class OfferCell: UITableViewCell {
    var title = UILabel()
    var mImage: ImageView!
    var detailLabel: UILabel!
    
    // MARK: - 💖 生命周期 (Lifecycle)
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - 💜 UITableViewDelegate
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        mImage = ImageView(frame: CGRectMake(PADDING, 5, 80, 70))
        mImage.contentMode = .ScaleAspectFit
        addSubview(mImage)
        addSubview(title)
        detailLabel = UILabel(frame: CGRectMake(frame.width - 100 - 2 * PADDING, 0, 100, 80))
        detailLabel.textAlignment = .Right
        addSubview(detailLabel)
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func setData(data: Offer) {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        detailLabel.text = "\(formatter.stringFromNumber(NSNumber(double: data.quotedPrice.doubleValue))!)"
        detailLabel.sizeToFit()
        detailLabel.frame.origin = CGPointMake(SCREEN_WIDTH - detailLabel.bounds.width - 2 * PADDING, (80 - detailLabel.bounds.height) / 2)
        detailLabel.textColor = .blackColor()
        title.text = data.agent.name
        title.frame = CGRectMake(1.5 * PADDING + 80, detailLabel.frame.origin.y, SCREEN_WIDTH - (3.5 * PADDING + 80 + detailLabel.bounds.width), detailLabel.bounds.height)
        mImage.sd_setImageWithURL(NSURL(string: data.brand.image_url), placeholderImage: UIImage(named: "logo_brand_2.png"))
    }
}
