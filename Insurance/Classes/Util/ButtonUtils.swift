//
//  Copyright © 2015年 NY. All rights reserved.
//

enum Style: Int {
    case Light, Dark
}

func getButton(frame: CGRect, title: String = "", theme: Theme = STYLE_BUTTON_DARK) -> UIButton {
    // type = 0 是红框 白底 红字
    let button = UIButton(frame: frame)
    button.backgroundColor = theme.type.rawValue == 0 ? .clearColor() : .colorWithHex(theme.color, alpha: theme.alpha)
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.colorWithHex(theme.color, alpha: theme.alpha).CGColor
    button.layer.cornerRadius = 3
    button.setTitle(title, forState: .Normal)
    button.titleLabel?.textAlignment = .Center
    button.setTitleColor(theme.type.rawValue == 0 ? .colorWithHex(theme.color, alpha: theme.alpha) : .whiteColor(), forState: .Normal)
    button.setTitleColor(theme.type.rawValue == 0 ? .colorWithHex(theme.color, alpha: 0.5) : UIColor.whiteColor().colorWithAlphaComponent(0.5), forState: .Highlighted)
    return button
}

class Theme {
    var color: Int!
    var alpha: CGFloat!
    var type: Style!
    
    init(type: Style = .Dark, color: Int = 0x007AFF, alpha: CGFloat = 1) {
        self.color = color
        self.alpha = alpha
        self.type = type
    }
}

let STYLE_BUTTON_DARK = Theme(color: APP_COLOR, alpha: 0.7)
let STYLE_BUTTON_LIGHT = Theme(type: .Light, color: APP_COLOR)
