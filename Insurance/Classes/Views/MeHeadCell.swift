//
//  Copyright © 2015年 NY. All rights reserved.
//

class MeHeadCell: UITableViewCell {
    var headImageView: ImageView!
    var title = UILabel()
    var subTitle = UILabel()
    
    // MARK: - 💖 初始化
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        headImageView = ImageView(frame: CGRectMake(PADDING, 10, 60, 60), cornerRadius: 30)
        headImageView.tintColor = .colorWithHex(APP_COLOR)
        addSubview(headImageView)
        title.frame = CGRectMake(2 * PADDING + 60, 0, 0, 0)
        addSubview(title)
        subTitle.textColor = .grayColor()
        subTitle.textAlignment = .Right
        addSubview(subTitle)
    }
    
    func setHeadViewData(data: User) {
        headImageView.sd_setImageWithURL(NSURL(string: data.imageUrl), placeholderImage: UIImage(named: "ic_user_c120.png")?.imageWithRenderingMode(.AlwaysTemplate))
        title.text = data.nickname
        title.sizeToFit()
        title.frame.size.width = title.frame.width > SCREEN_WIDTH - 4 * PADDING - 60 ?  SCREEN_WIDTH - 4 * PADDING - 60 : title.frame.width
        title.center.y = headImageView.center.y
        subTitle.text = data.about
        subTitle.sizeToFit()
        subTitle.frame.origin.x = CGRectGetMaxX(title.frame) + PADDING
        subTitle.frame.size.width = SCREEN_WIDTH - 2 * PADDING - 3 * PADDING_INNER - title.frame.width - 65
        subTitle.hidden = subTitle.frame.width > 10 ? false : true
        subTitle.center.y = title.center.y
    }
}
