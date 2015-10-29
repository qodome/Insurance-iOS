//
//  Copyright © 2015年 NY. All rights reserved.
//

class LocationCell: UITableViewCell {
    var title: UILabel!
    var typeImage: ImageView!
    var ActivityView: UIActivityIndicatorView!
    
    // MARK: - 💖 生命周期 (Lifecycle)
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - 💜 UITableViewDelegate
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        ActivityView = UIActivityIndicatorView(frame: CGRectMake(PADDING, (frame.height - 20) / 2, 20, 20))
        ActivityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        ActivityView.startAnimating()
        ActivityView.hidden = false
        addSubview(ActivityView)
        typeImage = ImageView(frame: CGRectMake(PADDING, (frame.height - CGSizeSettingsIcon.height) / 2, CGSizeSettingsIcon.width, CGSizeSettingsIcon.height))
        typeImage.hidden = true
        let iconInsurances = FAKIonIcons.locationIconWithSize(CGSizeSettingsIcon.width)
        iconInsurances.addAttribute(NSForegroundColorAttributeName, value: UIColor.colorWithHex(XIAOMAR_GREEN))
        typeImage.image = iconInsurances.imageWithSize(CGSizeSettingsIcon)
        addSubview(typeImage)
        title = UILabel(frame: CGRectMake(PADDING + CGSizeSettingsIcon.width + 5, 0, frame.width - 2 * PADDING - 45, frame.height))
        title.text = "定位中..."
        title.textAlignment = .Left
        addSubview(title)
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func changeTitle(string: String) {
        title.text = string
        title.sizeToFit()
        title.frame.origin = CGPointMake(PADDING + CGSizeSettingsIcon.width + 5, (frame.height - title.frame.height) / 2)
        typeImage.hidden = false
        ActivityView.stopAnimating()
        ActivityView.hidden = true
    }
    
    func startLocation() {
        typeImage.hidden = true
        title.text = "定位中..."
        ActivityView.startAnimating()
        ActivityView.hidden = false
    }
}
