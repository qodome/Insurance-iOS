//
//  Copyright © 2015年 NY. All rights reserved.
//

class MeHeadCell: UITableViewCell {
    var headImageView: ImageView!
    let title = UILabel()
    let subtitle = UILabel()
    
    // MARK: - 💖 初始化
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        headImageView = ImageView(frame: CGRectMake(PADDING, 10, 60, 60), cornerRadius: 30)
        headImageView.tintColor = .colorWithHex(APP_COLOR)
        addSubview(headImageView)
        title.frame = CGRectMake(PADDING + PADDING_INNER + 60, 0, 0, 0)
        addSubview(title)
        subtitle.textColor = .grayColor()
        subtitle.textAlignment = .Right
        addSubview(subtitle)
    }
    
    func setHeadViewData(data: User) {
        headImageView.sd_setImageWithURL(NSURL(string: data.imageUrl), placeholderImage: UIImage(named: "ic_user_c120.png")?.imageWithRenderingMode(.AlwaysTemplate))
        title.text = data.nickname
        title.sizeToFit()
        title.frame.size.width = title.frame.width > SCREEN_WIDTH - 3 * PADDING - PADDING_INNER - 60 ? SCREEN_WIDTH - 3 * PADDING - PADDING_INNER - 60 : title.frame.width
        title.center.y = headImageView.center.y
        subtitle.text = data.about
        subtitle.sizeToFit()
        subtitle.frame.origin.x = CGRectGetMaxX(title.frame) + PADDING_INNER
        let subWidth = SCREEN_WIDTH - 3 * PADDING - 2 * PADDING_INNER - title.frame.width - 65
        subtitle.frame.size.width = subWidth
        subtitle.hidden = subWidth <= 10
        subtitle.center.y = title.center.y
    }
}
