//
//  Copyright © 2015年 NY. All rights reserved.
//

func getType(string: String) -> String {
    switch string {
    case "a":
        return LocalizedString("article")
    case "v":
        return LocalizedString("video")
    default:
        return ""
    }
}

func getCardCell(item: Card, cell: CardCell) -> CardCell {
    let width = cell.frame.width
    cell.title.text = item.caption
    cell.subtitle.text = [getType(item.type), "\(item.comments.count) 评论"].joinWithSeparator(" · ")
    cell.icon.image = UIImage(named: "ferrari")
    let image = ImageView(frame: CGRectMake(0, 0, width, cell.heightRate * width))
    image.backgroundColor = .lightGrayColor()
    image.sd_setImageWithURL(NSURL(string: item.imageUrl))
    cell.addPage(image)
    if item.imageCount.integerValue > 1 { // 如果图片数大于1
        for i in 2...item.imageCount.integerValue {
            let image = ImageView(frame: CGRectMake(CGFloat(i - 1) * width, 0, width, cell.heightRate * width))
            image.backgroundColor = .lightGrayColor()
//            let url = "\(item.imageUrl.stringByDeletingLastPathComponent)\(i).\(item.imageUrl.pathExtension)" // 注意这样出来的是http:/而非http://
            let url = ""
            image.sd_setImageWithURL(NSURL(string: url))
            cell.addPage(image)
        }
    }
    return cell
}
