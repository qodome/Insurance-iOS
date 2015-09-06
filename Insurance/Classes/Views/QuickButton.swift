//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class QuickButton: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.colorWithHex(APP_COLOR).colorWithAlphaComponent(0.7)
        setTitleColor(UIColor.whiteColor(), forState: .Normal)
        setTitleColor(UIColor.whiteColor().colorWithAlphaComponent(0.5), forState: .Highlighted)
    }
}
