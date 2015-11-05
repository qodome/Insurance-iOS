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
        aboutLabel.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        addSubview(aboutLabel)
    }
    
    func setHeadViewData(data: User) {
        headImageView.sd_setImageWithURL(NSURL(string: data.imageUrl), placeholderImage: .imageWithColor(UIColor.whiteColor().colorWithAlphaComponent(0), size: CGSizeMake(60, 60)))
        nickNameLabel.text = data.nickname
        nickNameLabel.sizeToFit()
        nickNameLabel.center.y = headImageView.center.y
        aboutLabel.frame.origin.x = SCREEN_WIDTH - 5 * PADDING - nickNameLabel.frame.width - 60
        aboutLabel.text = data.about
        aboutLabel.center.y = nickNameLabel.center.y
        
    }
}
