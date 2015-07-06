//
//  Copyright (c) 2014年 NY. All rights reserved.
//

class PosterView: UIView {
    
    var title: UILabel!
    var image: ImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        image = ImageView(frame: CGRect(origin: CGPointZero, size: frame.size))
        addSubview(image)
        title = UILabel(frame: CGRectMake(0, 0, frame.width - 2 * PADDING, 0))
        title.font = UIFont.boldSystemFontOfSize(32)
        title.textColor = UIColor.whiteColor()
        title.textAlignment = .Center
        title.numberOfLines = 0
        addSubview(title)
    }
    
    func changeTitle(string: String) {
        title.text = string
        title.sizeToFit()
        title.frame.origin = CGPointMake((frame.width - title.frame.width) / 2, (frame.height - title.frame.height) / 2)
    }
}
