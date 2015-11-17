//
//  Copyright © 2015年 NY. All rights reserved.
//

class BaseCardList: CollectionList {
    var navController: UINavigationController?
    var category = Category()
    
    // MARK: - 🐤 Taylor
    override func onPrepare<T : UICollectionView>(listView: T) {
        super.onPrepare(listView)
        endpoint = "\(getEndpoint("popping/topcharts"))&category=\(category.name)"
        mapping = getListMapping(Card.self)
        refreshMode = .DidLoad
    }
    
    override func getItemView<V : UICollectionView, T : Card, C : CardListCell>(listView: V, indexPath: NSIndexPath, item: T, cell: C) -> C {
        cell.image.sd_setImageWithURL(NSURL(string: item.imageUrl))
        cell.captionLabel.text = item.caption
        cell.setTips(item.tips)
        return cell
    }
    
    override func onPerform<T : Card>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            if item.site == "App Store" {
                UIApplication.sharedApplication().openURL(NSURL(string: item.url)!)
            } else {
                let dest = CardWebDetail()
                dest.title = item.caption
                dest.setValue(item.url, forKey: "url")
                dest.setValue(item, forKey: "data")
                dest.hidesBottomBarWhenPushed = true
                navController?.pushViewController(dest, animated: true) // TODO: 跳转进度条蓝色
                // performSegueWithIdentifier("segue.home-web_card_detail", sender: self)
                // 待调整为框架通用模式
            }
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
    }
    
    override func onSegue(segue: UIStoryboardSegue?, dest: UIViewController, id: String) {
        let item = getSelected().first
        dest.setValue(item, forKey: "data")
    }
}
