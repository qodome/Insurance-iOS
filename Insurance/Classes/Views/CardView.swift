//
//  Copyright (c) 2014年 NY. All rights reserved.
//

class CardView: UIView {
    
    let iconRadius: CGFloat = 23.0
    
    var title: UILabel!
    var subtitle: UILabel!
    var icon: ImageView!
    var image: ImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        image = ImageView(frame: CGRectMake(0, 0, frame.width, frame.width * 2 / 3))
        addSubview(image)
        let center = frame.height / 2 + frame.width / 3 // 文字区域的中心线
        title = UILabel(frame: CGRectMake(PADDING, center - 22, frame.width - 2 * iconRadius - 2 * PADDING, 20))
        title.textColor = UIColor.colorWithHex(PRIMARY_TEXT_COLOR)
        addSubview(title)
        subtitle = UILabel(frame: CGRectMake(PADDING, center + 2, frame.width - 2 * PADDING, 17))
        subtitle.textColor = UIColor.colorWithHex(SECONDARY_TEXT_COLOR)
        subtitle.font = UIFont.systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        addSubview(subtitle)
        icon = ImageView(frame: CGRectMake(frame.width - 2 * iconRadius - PADDING, frame.width * 2 / 3 - iconRadius, 2 * iconRadius, 2 * iconRadius), cornerRadius: iconRadius)
        icon.layer.borderColor = UIColor.whiteColor().CGColor
        icon.layer.borderWidth = 1
        // addSubview(icon)
    }
}
