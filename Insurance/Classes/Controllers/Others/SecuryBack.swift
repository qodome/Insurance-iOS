//
//  Copyright © 2015年 NY. All rights reserved.
//

class SecuryBack: GroupedTableDetail, UITextFieldDelegate {
    let phoneField = UITextField()
    let codeField = UITextField()
    let newSecuryField = UITextField()
    let nextSecuryField = UITextField()
    var textFieldArray: [UITextField] = []
    var signOutBtn: UIButton!
    var resignBtn: UIButton!
    
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true) // 放在这里保证横滑键盘消失体验一致
    }
    
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        endpoint = getEndpoint("repassword")
        mapping = getDetailMapping(User.self)
        items = [[Item.emptyItem(), Item.emptyItem(), Item.emptyItem(), Item.emptyItem()]]
        resignBtn = QuickButton(frame: CGRectMake(PADDING, 60 + 44 * 4 + PADDING, view.frame.width - 2 * PADDING, 50), title: LocalizedString("完成"), theme: STYLE_BUTTON_DARK)
        resignBtn.addTarget(self, action: "create", forControlEvents: .TouchUpInside)
        tableView.addSubview(resignBtn)
        textFieldArray = [phoneField, newSecuryField, nextSecuryField, codeField]
        let placeArray = [LocalizedString("输入手机号"), LocalizedString("输入新密码"), LocalizedString("确认新密码"), LocalizedString("输入验证码")]
        for (index, field) in textFieldArray.enumerate() {
            field.tag = index
            field.keyboardType = .ASCIICapable
            field.placeholder = placeArray[index]
            field.clearButtonMode = .WhileEditing
            field.delegate = self
            field.secureTextEntry = [1, 2].contains(index)
            field.returnKeyType = index == 3 ? .Done :.Next
        }
    }
    
    override func onLoadSuccess<E : User>(entity: E) {
        super.onLoadSuccess(entity)
        cancel()
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        let field = textFieldArray[indexPath.row]
        field.frame = CGRectMake(PADDING, 0, view.frame.width - 2 * PADDING, cell.frame.height)
        if indexPath.row == 3 {
            field.frame.size.width = view.frame.width - 2 * PADDING - 80
            signOutBtn = QuickButton(frame: CGRectMake(view.frame.width - 80 - PADDING / 2, 5, 80, cell.frame.height - 10), title: LocalizedString("短信验证"), theme: STYLE_BUTTON_LIGHT)
            signOutBtn.addTarget(self, action: "getCode", forControlEvents: .TouchUpInside)
            cell.contentView.addSubview(signOutBtn)
        }
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
        return LocalizedString("请使用已注册过的手机号找回密码")
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func create() {
        if phoneField.text!.isEmpty || codeField.text!.isEmpty || newSecuryField.text!.isEmpty || nextSecuryField.text!.isEmpty {
            showAlert(self, message: LocalizedString("请把信息填写完整"))
            return
        }
        if newSecuryField.text != nextSecuryField.text {
            showAlert(self, message: LocalizedString("输入的两次新密码不一致，请核对后重试"))
        } else {
            loader?.update(parameters: ["username" : phoneField.text!, "password" : newSecuryField.text!, "code" : codeField.text!])
        }
    }
    
    func getCode() {
        if phoneField.text?.length != 11 {
            showAlert(self, message: LocalizedString("请填写正确的手机号"))
            return
        }
        let mapping = getDetailMapping(Sms.self)
        let descriptor = RKResponseDescriptor(mapping: mapping, method: .Any, pathPattern: nil, keyPath: nil, statusCodes: RKStatusCodeIndexSetForClass(.Successful))
        RKObjectManager.sharedManager().HTTPClient.setDefaultHeader("Authorization", value: "")
        RKObjectManager.sharedManager().addResponseDescriptor(descriptor)
        RKObjectManager.sharedManager().postObject(mapping, path: getEndpoint("send_sms"), parameters: ["mobile" : phoneField.text!, "send_verify_code" : "xiaomar_send_sms"], success: { operation, result in
            let getResult = result.firstObject as! Sms
            getResult.code == 0 ? self.waitingCode() : showAlert(self, title: "Error", message: getResult.reason)
            }) { operation, error in
                showAlert(self, title: "Send SMS Error", message: error.localizedDescription)
        }
    }
    
    func waitingCode() {
        var timeout = 60 //倒计时时间
        let _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
        dispatch_source_set_timer(_timer, dispatch_walltime(nil, 0), NSEC_PER_SEC, 0)
        dispatch_source_set_event_handler(_timer) { () in
            self.signOutBtn.userInteractionEnabled = timeout <= 0
            if timeout <= 0 {
                dispatch_source_cancel(_timer)
                delay(0.2) {
                    self.signOutBtn.titleLabel?.text = LocalizedString("短信验证")
                }
            } else {
                delay(0.2) {
                    self.signOutBtn.titleLabel?.text = "\(timeout == 60 ? 60 : timeout % 60)秒"
                }
                timeout--
            }
        }
        dispatch_resume(_timer)
    }
}
