//
//  Copyright © 2015年 NY. All rights reserved.
//

class CardListCell: UICollectionViewCell {
    var image: UIImageView!
    var captionLabel: UILabel!
    var tipLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        image = ImageView(frame: CGRectMake(0, 0, frame.width, frame.width * 3 / 5))
        addSubview(image)
        captionLabel = UILabel(frame: CGRectMake(PADDING, image.frame.height, frame.width - 2 * PADDING, 44))
        captionLabel.numberOfLines = 2
        addSubview(captionLabel)
        tipLabel = UILabel(frame: CGRectMake(PADDING, CGRectGetMaxY(captionLabel.frame), frame.width - 2 * PADDING, 44))
        tipLabel.numberOfLines = 2
        tipLabel.textColor = UIColor.redColor()
        addSubview(tipLabel)
    }
    
    func setTips(string: String) {
        tipLabel.text = string
        tipLabel.frame.origin.y = captionLabel.frame.origin.y + captionLabel.frame.height
    }
}
