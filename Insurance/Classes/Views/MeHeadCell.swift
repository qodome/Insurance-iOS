//
//  Copyright © 2015年 NY. All rights reserved.
//

class MeHeadCell: UITableViewCell {
    var headImageView = UIImageView()
    var nickNameLabel = UILabel()
    var aboutLabel = UILabel()
    
    // MARK: - 💖 初始化
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - 💜 UITableViewDelegate
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        headImageView.frame = CGRectMake(PADDING, 10, 60, 60)
        addSubview(headImageView)
        nickNameLabel.frame = CGRectMake(2 * PADDING + 60, 0, 0, 0)
        addSubview(nickNameLabel)
        aboutLabel.textColor = .grayColor()
        aboutLabel.textAlignment = .Right
        addSubview(aboutLabel)
    }
    
    func setHeadViewData(data: User) {
        headImageView.sd_setImageWithURL(NSURL(string: data.imageUrl), placeholderImage: .imageWithColor(UIColor.whiteColor().colorWithAlphaComponent(0), size: CGSizeMake(60, 60)))
        nickNameLabel.text = data.nickname
        nickNameLabel.sizeToFit()
        nickNameLabel.frame.size.width = nickNameLabel.frame.width > SCREEN_WIDTH - 4 * PADDING - 60 ?  SCREEN_WIDTH - 4 * PADDING - 60 : nickNameLabel.frame.width
        nickNameLabel.center.y = headImageView.center.y
        aboutLabel.text = data.about
        aboutLabel.sizeToFit()
        aboutLabel.frame.origin.x = nickNameLabel.frame.width + nickNameLabel.frame.origin.x + PADDING
        aboutLabel.frame.size.width = SCREEN_WIDTH - 5 * PADDING - nickNameLabel.frame.width - 65
        aboutLabel.hidden = SCREEN_WIDTH - 5 * PADDING - nickNameLabel.frame.width - 65 > 10 ? false : true
        aboutLabel.center.y = nickNameLabel.center.y
    }
}
