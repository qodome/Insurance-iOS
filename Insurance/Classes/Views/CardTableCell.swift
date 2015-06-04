//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class CardTableCell: UICollectionViewCell {
    var siteLabel: UILabel!
    var captionLabel: UILabel!
    var image: UIImageView!
    var tipLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let height = frame.height
        image = ImageView(frame: CGRectMake(0, 0, height, height))
        addSubview(image)
        siteLabel = UILabel(frame: CGRectMake(70, 0, frame.width - 80, 20))
        siteLabel.font = UIFont.systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
//        addSubview(siteLabel)
        let left = CGRectGetMaxX(image.frame) + PADDING
        captionLabel = UILabel(frame: CGRectMake(left, 0, frame.width - left - PADDING, 28))
        captionLabel.numberOfLines = 2
        captionLabel.textColor = UIColor.colorWithHex(PRIMARY_TEXT_COLOR)
        addSubview(captionLabel)
        tipLabel = UILabel(frame: CGRectMake(left, CGRectGetMaxY(captionLabel.frame), frame.width - left - PADDING, 20))
        tipLabel.font = UIFont.systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        tipLabel.textColor = UIColor.redColor()
        addSubview(tipLabel)
    }
    
    func setSite(string: String) {
        siteLabel.text = string
        siteLabel.sizeToFit()
    }
    
    func setTips(string: String) {
        tipLabel.text = string
        tipLabel.frame.origin.y = CGRectGetMaxY(captionLabel.frame)
    }
}
