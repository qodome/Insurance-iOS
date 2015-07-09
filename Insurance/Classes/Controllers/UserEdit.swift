//
//  Copyright (c) 2015年 NY. All rights reserved.
//

protocol UpdatedDelegate {
    func onBackSegue(data: NSObject?)
}

class UserEdit: BaseFieldEdit {
    var fieldName = ""
    var delegate: UpdatedDelegate?
    
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        title = LocalizedString(fieldName)
        endpoint = getEndpoint("users/\((data as! User).id)")
        textField.text = data?.valueForKey(fieldName) as? String
        text = textField.text
    }
    
    override func onCreateLoader() -> BaseLoader? {
        return HttpLoader(endpoint: endpoint, type: User.self)
    }
    
    override func onLoadSuccess<E : User>(entity: E) {
        super.onLoadSuccess(entity)
        delegate?.onBackSegue(entity)
        cancel()
    }
    
    override func onUpdate(string: String) {
        (loader as? HttpLoader)?.patch(parameters: [fieldName : textField.text])
    }
    
    override func getItemView<T : User, C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, data: T?, item: String, cell: C) -> UITableViewCell {
        cell.addSubview(textField)
        return cell
    }
}
