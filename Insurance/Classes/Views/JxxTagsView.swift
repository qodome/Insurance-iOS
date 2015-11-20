//
//  Copyright © 2014年 NY. All rights reserved.
//

class JxxTagsView: UIView {
    var theme: TagsTheme = STYLE_TAGVIEW_SHORT
    var returnWidth: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setTags(tags: [String], target: AnyObject?, action: Selector) {
        var x = PADDING // 左边距
        var y: CGFloat = theme.tagViewHight / 2 // 上边距10
        for tag in tags {
            let btn = getBtn(tag, width: bounds.width - 32)
            returnWidth = x + btn.frame.width
            if x + btn.frame.width + 16 + theme.tagViewHight / 2 > bounds.width {
                x = PADDING
                y += btn.frame.height + theme.tagViewHight / 2
            }
            btn.frame.origin = CGPointMake(x, y)
            x += btn.frame.width + theme.tagViewHight / 2
            addSubview(btn)
            btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        }
        frame.size.height = y + theme.tagViewHight + theme.tagViewHight / 2 // 行高28 下边距10
    }
    
    func getBtn(title: String, width: CGFloat) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, forState: [])
        btn.setTitleColor(.colorWithHex(theme.color), forState: [])
        btn.titleLabel?.font = .systemFontOfSize(theme.textFont)
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, theme.tagViewHight / 2, 0, theme.tagViewHight / 2)
        btn.sizeToFit()
        btn.layer.cornerRadius = theme.tagViewHight / 2 - 1
        btn.layer.borderColor = UIColor.colorWithHex(theme.color).CGColor
        btn.layer.borderWidth = 1
        btn.frame.size.height = theme.tagViewHight
        if btn.frame.width > width {
            btn.frame.size.width = width
        }
        return btn
    }
    
    func getWidth() -> CGFloat {
        return returnWidth
    }
}

class TagsTheme {
    var color: Int!
    var textFont: CGFloat!
    var tagViewHight: CGFloat!
    
    init(tagViewHight: CGFloat = 15, color: Int = XIAOMAR_GREEN, textFont: CGFloat = DEFAULT_FONT_SIZE_SMALL - 4) {
        self.color = color
        self.textFont = textFont
        self.tagViewHight = tagViewHight
    }
}

let STYLE_TAGVIEW_SHORT = TagsTheme(color: APP_COLOR, textFont: DEFAULT_FONT_SIZE_SMALL - 4)
let STYLE_TAGVIEW_LIGHT = TagsTheme(tagViewHight: 15, color: APP_COLOR)
