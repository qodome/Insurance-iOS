//
//  Copyright © 2015年 NY. All rights reserved.
//

class MeHeadCell: UITableViewCell {
    var headImageView: ImageView!
    var nickNameLabel = UILabel()
    var aboutLabel = UILabel()
    
    // MARK: - 💖 初始化
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        headImageView = ImageView(frame: CGRectMake(PADDING, 10, 60, 60), cornerRadius: 30)
        headImageView.tintColor = .colorWithHex(APP_COLOR)
        addSubview(headImageView)
        nickNameLabel.frame = CGRectMake(2 * PADDING + 60, 0, 0, 0)
        addSubview(nickNameLabel)
        aboutLabel.textColor = .grayColor()
        aboutLabel.textAlignment = .Right
        addSubview(aboutLabel)
    }
    
    func setHeadViewData(data: User) {
        headImageView.sd_setImageWithURL(NSURL(string: data.imageUrl), placeholderImage: UIImage(named: "ic_user_c120.png")?.imageWithRenderingMode(.AlwaysTemplate))
        nickNameLabel.text = data.nickname
        nickNameLabel.sizeToFit()
        nickNameLabel.frame.size.width = nickNameLabel.frame.width > SCREEN_WIDTH - 4 * PADDING - 60 ?  SCREEN_WIDTH - 4 * PADDING - 60 : nickNameLabel.frame.width
        nickNameLabel.center.y = headImageView.center.y
        aboutLabel.text = data.about
        aboutLabel.sizeToFit()
        aboutLabel.frame.origin.x = CGRectGetMaxX(nickNameLabel.frame) + PADDING
        aboutLabel.frame.size.width = SCREEN_WIDTH - 2 * PADDING - 3 * PADDING_INNER - nickNameLabel.frame.width - 65
        aboutLabel.hidden = aboutLabel.frame.width > 10 ? false : true
        aboutLabel.center.y = nickNameLabel.center.y
    }
}
