//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class Discover: TableSearch {
    // MARK: - 🐤 Taylor
    override func onPrepare<T : UITableView>(listView: T) {
        super.onPrepare(listView)
        endpoint = getEndpoint("popping/categories")
        refreshMode = .DidLoad
        // searchController.searchBar.scopeButtonTitles = ["a", "b"]
    }
    
    override func onCreateLoader() -> BaseLoader {
        return HttpLoader(endpoint: endpoint, mapping: smartListMapping(Category.self))
    }
    
    override func getItemView<V : UITableView, T : Category, C : UITableViewCell>(listView: V, indexPath: NSIndexPath, item: T, cell: C) -> C {
        cell.textLabel?.text = item.name as String
        return cell
    }
    
    override func onPerform<T : Category>(action: Action, item: T) {
        switch action {
        case .Open:
            startActivity(Item(title: "cards", dest: CardList.self))
        default:
            super.onPerform(action, item: item)
        }
    }
    
    override func onSegue(segue: UIStoryboardSegue, dest: UIViewController, id: String) {
        let item = getSelected().first as? Category
        dest.setValue(item, forKey: "category")
        dest.setValue(item?.name, forKey: "title")
    }
}
