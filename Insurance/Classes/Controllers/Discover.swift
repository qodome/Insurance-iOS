//
//  Copyright © 2015年 NY. All rights reserved.
//

class Discover: TableSearch {
    // MARK: - 🐤 Taylor
    override func onPrepare<T : UITableView>(listView: T) {
        super.onPrepare(listView)
        endpoint = getEndpoint("popping/categories")
        mapping = smartListMapping(Category.self)
        refreshMode = .DidLoad
        // searchController.searchBar.scopeButtonTitles = ["a", "b"]
    }
    
    override func getItemView<V : UITableView, T : Category, C : UITableViewCell>(listView: V, indexPath: NSIndexPath, item: T, cell: C) -> C {
        cell.textLabel?.text = item.name
        return cell
    }
    
    override func onPerform<T : Category>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            startActivity(Item(title: "cards", dest: CardList.self))
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
    }
    
    override func onSegue(segue: UIStoryboardSegue?, dest: UIViewController, id: String) {
        let item = getSelected().first as? Category
        dest.title = item?.name
        dest.setValue(item, forKey: "category")
    }
}
