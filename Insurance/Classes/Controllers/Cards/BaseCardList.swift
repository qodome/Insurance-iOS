//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class BaseCardList: CollectionList {
    var navController: UINavigationController?
    var category = Category()
    
    // MARK: - 🐤 Taylor
    override func onPrepare<T : UICollectionView>(listView: T) {
        super.onPrepare(listView)
        endpoint = getEndpoint("popping/topcharts")
        refreshMode = .DidLoad
    }
    
    override func onCreateLoader() -> BaseLoader {
        let mapping = smartListMapping(Card.self)
        return HttpLoader(endpoint: endpoint, mapping: mapping, parameters: ["category" : category.name])
    }
    
    override func getItemView<V : UICollectionView, T : Card, C : CardListCell>(listView: V, indexPath: NSIndexPath, item: T, cell: C) -> C {
        cell.image.sd_setImageWithURL(NSURL(string: item.imageUrl as String))
        cell.captionLabel.text = item.caption as String
        cell.setTips(item.tips as String)
        return cell
    }
    
    override func onPerform<T : Card>(action: Action, item: T) {
        switch action {
        case .Open:
            if item.site == "App Store" {
                UIApplication.sharedApplication().openURL(NSURL(string: item.url as String)!)
            } else {
                let dest = CardWebDetail()
                dest.setValue(item.url, forKey: "url")
                dest.setValue(item.caption, forKey: "title")
                dest.setValue(item, forKey: "data")
                dest.hidesBottomBarWhenPushed = true
                navController?.pushViewController(dest, animated: true) // TODO: 跳转进度条蓝色
                // performSegueWithIdentifier("segue.home-web_card_detail", sender: self)
            }
        default:
            super.onPerform(action, item: item)
        }
    }
    
    // MARK: - 💜 场景切换 (Segue)
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        let item = getSelected().first
        segue.destinationViewController.setValue(item, forKey: "data")
    }
}
