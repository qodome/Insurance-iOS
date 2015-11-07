//
//  Copyright © 2015年 NY. All rights reserved.
//

class SpecialCover: PosterView {
    
    var subtitle: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subtitle = UILabel(frame: CGRectMake(0, 0, frame.width - 64, 0))
        subtitle.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        subtitle.textColor = .whiteColor()
        subtitle.textAlignment = .Center
        subtitle.numberOfLines = 0
        addSubview(subtitle)
    }
    
    override func changeTitle(string: String) {
        super.changeTitle(string)
        title.frame.origin = CGPointMake(title.frame.origin.x, frame.height / 2 - title.frame.height - 7)
    }
    
    func changeSubtitle(string: String) {
        subtitle.text = string
        subtitle.sizeToFit()
        subtitle.frame = CGRectMake((frame.width - subtitle.frame.width - 32) / 2, frame.height / 2 + 7, subtitle.frame.width + 32, subtitle.frame.height)
    }
    
    func changeSubtitleBackground(color: UIColor) {
        subtitle.backgroundColor = color
        subtitle.frame.size.height = subtitle.frame.height + 25
    }
}
