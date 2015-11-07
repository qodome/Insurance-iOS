//
//  Copyright © 2015年 NY. All rights reserved.
//

class CardCell: PageCell {
    // MARK: - 🍀 变量
    var iconRadius: CGFloat = 23.0
    
    var title: UILabel!
    var subtitle: UILabel!
    var icon: ImageView!
    
    var heightRate: CGFloat = 2 / 3
    
    // MARK: - 💖 初始化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let center = frame.height / 2 + frame.width / 3 // 文字区域的中心线
        title = UILabel(frame: CGRectMake(PADDING, center - 22, frame.width - 2 * iconRadius - 2 * PADDING, 20))
        title.textColor = .colorWithHex(PRIMARY_TEXT_COLOR)
        addSubview(title)
        subtitle = UILabel(frame: CGRectMake(PADDING, center + 2, frame.width - 2 * PADDING, 17))
        subtitle.textColor = .colorWithHex(SECONDARY_TEXT_COLOR)
        subtitle.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        addSubview(subtitle)
        icon = ImageView(frame: CGRectMake(frame.width - 2 * iconRadius - PADDING, frame.width * 2 / 3 - iconRadius, 2 * iconRadius, 2 * iconRadius), cornerRadius: iconRadius)
        icon.layer.borderColor = UIColor.whiteColor().CGColor
        icon.layer.borderWidth = 1
        // addSubview(icon)
    }
    
    // MARK: - 💜 UIScrollViewDelegate
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        icon.hidden = scrollView.contentOffset.x > 0
    }
}
