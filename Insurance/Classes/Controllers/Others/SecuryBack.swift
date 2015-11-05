//
//  Copyright © 2015年 NY. All rights reserved.
//

class SecuryBack: GroupedTableDetail, UITextFieldDelegate {
    let phoneNum = UITextField()
    let codeNum = UITextField()
    let newSecury = UITextField()
    let newNextSecury = UITextField()
    var textFieldArray: [UITextField] = []
    let signOutBtn = QuickButton()
    var resignBtn = QuickButton()
    
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true) // 放在这里保证横滑键盘消失体验一致
    }
    
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        buildView()
        navigationItem.rightBarButtonItem?.enabled = false
        items = [[Item.emptyItem(), Item.emptyItem(), Item.emptyItem(), Item.emptyItem()]]
        resignBtn.frame = CGRectMake(PADDING, 60 + 44 * 4 + PADDING, view.frame.width - 2 * PADDING, 50)
        resignBtn.addTarget(self, action: "create", forControlEvents: .TouchUpInside)
        resignBtn.enabled = false
        resignBtn.setTitle(LocalizedString("完成"), forState: .Normal)
        resignBtn.layer.cornerRadius = 3
        tableView.addSubview(resignBtn)
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        let field = textFieldArray[indexPath.row]
        field.frame = CGRectMake(PADDING, 0, SCREEN_WIDTH - 2 * PADDING, cell.frame.height)
        if indexPath.row == 1 {
            field.frame = CGRectMake(PADDING, 0, SCREEN_WIDTH - 2 * PADDING - 80, cell.frame.height)
            signOutBtn.frame = CGRectMake(SCREEN_WIDTH - 80 - PADDING / 2, 5, 80, cell.frame.height - 10)
            signOutBtn.setTitle("短信验证", forState: .Normal)
            signOutBtn.titleLabel?.textAlignment = .Center
            signOutBtn.addTarget(self, action: "getCodeNum", forControlEvents: .TouchUpInside)
            cell.contentView.addSubview(signOutBtn)
        }
        cell.contentView.addSubview(field)
        return cell
    }
    
    //    override func onCreateLoader() -> BaseLoader? {
    //        let mapping = smartMapping(CheckEnquiry.self)
    //        return HttpLoader(endpoint: endpoint, mapping: mapping)
    //    }
    //
    //    override func onLoadSuccess<E : CheckEnquiry>(entity: E) {
    //        LOG(Int(entity.status))
    //    }
    
    // MARK: - 💜 UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let next = view.viewWithTag(textField.tag + 1) {
            next.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "使用已注册的手机号找回密码"
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func buildView() {
        textFieldArray = [phoneNum, codeNum, newSecury, newNextSecury]
        let placeArray: [String] = ["输入手机号", "验证码", "输入密码", "确认密码"]
        for i in 0..<placeArray.count {
            let field = textFieldArray[i]
            field.tag = Int(i)
            field.secureTextEntry = true
            field.keyboardType = .ASCIICapable
            field.placeholder = placeArray[i]
            field.clearButtonMode = .WhileEditing
            field.delegate = self
            field.returnKeyType = .Next
            if i == placeArray.count - 1 {
                field.returnKeyType = .Done
            }
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "enable", name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    func enable() {
        resignBtn.enabled = !phoneNum.text!.isEmpty && !codeNum.text!.isEmpty && !newSecury.text!.isEmpty && !newNextSecury.text!.isEmpty ? true : false
    }
    
    func create() {
        if newSecury.text != newNextSecury.text {
            showAlert(self, title: "输入的两次新密码不一致，请核对后重试", message: "")
        }else {
            //            (loader as! HttpLoader).post(nil, parameters: ["": ""])
        }
    }
    
    func getCodeNum() {
        self.waitingCode()
    }
    
    func waitingCode() {
        var timeout = 60 //倒计时时间
        let _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
        dispatch_source_set_timer(_timer, dispatch_walltime(nil, 0), NSEC_PER_SEC, 0)
        dispatch_source_set_event_handler(_timer) { () in
            self.signOutBtn.userInteractionEnabled = timeout <= 0 ? true : false
            if timeout <= 0 {
                dispatch_source_cancel(_timer)
                delay(0.2, closure: { () in
                    self.signOutBtn.titleLabel?.text = "短信验证"
                })
            } else {
                delay(0.2, closure: { () in
                    self.signOutBtn.titleLabel?.text = "\(timeout == 60 ? 60 : timeout % 60)秒"
                })
                timeout--
            }
        }
        dispatch_resume(_timer)
    }
}