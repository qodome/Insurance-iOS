//
//  Copyright (c) 2014年 NY. All rights reserved.
//

class CommentCell: UICollectionViewCell {
    
    var name: UILabel!
    var dateLabel: UILabel!
    var text: UILabel!
    var image: ImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        image = ImageView(frame: CGRectMake(PADDING, 16, 32, 32), cornerRadius: 16)
        addSubview(image)
        let x = CGRectGetMaxX(image.frame) + PADDING_INNER
        name = UILabel(frame: CGRectMake(x, 16, frame.width, 24))
        name.textColor = UIColor.colorWithHex(SECONDARY_TEXT_COLOR)
        name.font = UIFont.systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        addSubview(name)
        dateLabel = UILabel(frame: CGRectMake(frame.width - 32, 16, frame.width, 24))
        dateLabel.textColor = UIColor.colorWithHex(SECONDARY_TEXT_COLOR)
        dateLabel.font = UIFont.systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        addSubview(dateLabel)
        text = UILabel(frame: CGRectMake(x, 40, frame.width - x - PADDING, 32))
        text.textColor = UIColor.colorWithHex(PRIMARY_TEXT_COLOR)
        text.numberOfLines = 0
        addSubview(text)
    }
    
    func changeText(string: String) {
        text.text = string
        text.sizeToFit()
        text.frame.size.width = frame.width - 80 // 不还原会越来越窄
    }
    
    func changeDate(date: NSDate) {
        dateLabel.text = TTTTimeIntervalFormatter().stringForTimeInterval(date.timeIntervalSinceNow)
        dateLabel.sizeToFit()
        dateLabel.frame.origin.x = frame.width - dateLabel.frame.width - PADDING
    }
    
    class func getHeight(string: String, width: CGFloat) -> CGFloat {
        let text = UILabel(frame: CGRectMake(64, 0, width - 96, 32))
        text.numberOfLines = 0
        text.text = string
        text.sizeToFit()
        return text.frame.height + 16 + 24
    }
}
