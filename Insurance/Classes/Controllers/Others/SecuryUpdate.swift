//
//  Copyright © 2015年 NY. All rights reserved.
//

class SecuryUpdate: GroupedTableDetail, UITextFieldDelegate {
    let newSecury = UITextField()
    let newNextSecury = UITextField()
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
        mapping = smartMapping(User.self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "create")
        navigationItem.rightBarButtonItem?.enabled = false
        items = [[Item.emptyItem(), Item.emptyItem()]]
        textFieldArray = [newSecury,newNextSecury]
        let placeArray: [String] = ["输入新密码", "再次输入新密码"]
        for (index, field) in textFieldArray.enumerate() {
            field.tag = index
            field.keyboardType = .ASCIICapable
            field.placeholder = placeArray[index]
            field.clearButtonMode = .WhileEditing
            field.delegate = self
            field.returnKeyType = index == 1 ? .Done : .Next
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "enable", name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    override func onLoadSuccess<E : ModelObject>(entity: E) {
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
    
    // MARK: 💜 UITableViewDataSource
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "密码只能是6-12位字母和英文字符，暂不支持中文和特殊字符"
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func enable() {
        navigationItem.rightBarButtonItem?.enabled = !newSecury.text!.isEmpty && !newNextSecury.text!.isEmpty ? true : false
    }
    
    func create() {
        if newSecury.text != newNextSecury.text {
            showAlert(self, title: "输入的两次新密码不一致，请核对后重试", message: "")
        } else {
            loader?.update(parameters: ["password" : newNextSecury.text!])
        }
    }
}
