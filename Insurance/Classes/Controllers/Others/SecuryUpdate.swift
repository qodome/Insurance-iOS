//
//  Copyright © 2015年 NY. All rights reserved.
//

class SecuryUpdate: GroupedTableDetail, UITextFieldDelegate {
    let newSecuryField = UITextField()
    let nextSecuryField = UITextField()
    var textFieldArray: [UITextField] = []
    
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true) // 放在这里保证横滑键盘消失体验一致
    }
    
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        endpoint = getEndpoint("users/\(userId)/password")
        mapping = getDetailMapping(User.self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "create")
        navigationItem.rightBarButtonItem?.enabled = false
        items = [[Item.emptyItem(), Item.emptyItem()]]
        textFieldArray = [newSecuryField,nextSecuryField]
        let placeArray = [LocalizedString("输入新密码"), LocalizedString("确认新密码")]
        for (index, field) in textFieldArray.enumerate() {
            field.tag = index
            field.keyboardType = .ASCIICapable
            field.placeholder = placeArray[index]
            field.secureTextEntry = true
            field.clearButtonMode = .WhileEditing
            field.delegate = self
            field.returnKeyType = index == 1 ? .Done : .Next
            if index == 0 {
                field.becomeFirstResponder()
            }
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "enable", name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    override func onLoadSuccess<E : ModelObject>(entity: E) {
        super.onLoadSuccess(entity)
        cancel()
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        let field = textFieldArray[indexPath.row]
        field.frame = CGRectMake(PADDING, 0, cell.frame.width - 2 * PADDING, cell.frame.height)
        cell.contentView.addSubview(field)
        return cell
    }
    
    // MARK: - 💜 UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let next = view.viewWithTag(textField.tag + 1) {
            next.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func enable() {
        navigationItem.rightBarButtonItem?.enabled = !newSecuryField.text!.isEmpty && !nextSecuryField.text!.isEmpty
    }
    
    func create() {
        if newSecuryField.text != nextSecuryField.text {
            showAlert(self, title: LocalizedString("输入的两次新密码不一致，请核对后重试"))
        } else {
            loader?.update(parameters: ["password" : nextSecuryField.text!])
        }
    }
}
