//
//  Copyright © 2015年 NY. All rights reserved.
//

class Register: GroupedTableDetail, UITextFieldDelegate {
    let nameField = UITextField()
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
        textFieldArray = [phoneField, nameField, newSecuryField, nextSecuryField, codeField]
        let placeArray = [ LocalizedString("输入手机号"), LocalizedString("输入昵称"), LocalizedString("输入密码"), LocalizedString("确认密码"), LocalizedString("输入验证码")]
        for (index, field) in textFieldArray.enumerate() {
            field.tag = index
            field.keyboardType = index == 1 ? .Default : .ASCIICapable
            field.placeholder = placeArray[index]
            field.clearButtonMode = .WhileEditing
            field.delegate = self
            field.returnKeyType = index == 4 ? .Done : .Next
        }
        items = [[Item.emptyItem() , Item.emptyItem(), Item.emptyItem(), Item.emptyItem(), Item.emptyItem()]]
        resignBtn = getButton(CGRectMake(PADDING, 60 + 44 * 5, view.frame.width - 2 * PADDING, 50), title: LocalizedString("register"), theme: STYLE_BUTTON_DARK)
        resignBtn.addTarget(self, action: "create", forControlEvents: .TouchUpInside)
        tableView.addSubview(resignBtn)
        let agreementBtn = UIButton(frame: CGRectMake(PADDING, 60 + 44 * 5 + 50 + PADDING, 0, 0))
        let mutableString = NSMutableAttributedString(string: "点击注册即表示您已同意《小马保险注册协议》")
        mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.colorWithHex(105070), range: NSMakeRange(11, 10))
        agreementBtn.setAttributedTitle(mutableString, forState: .Normal)
        agreementBtn.titleLabel!.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        agreementBtn.sizeToFit()
        agreementBtn.center.x = view.center.x
        agreementBtn.addTarget(self, action: "agreement", forControlEvents: .TouchUpInside)
        tableView.addSubview(agreementBtn)
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        let field = textFieldArray[indexPath.row]
        field.frame = CGRectMake(PADDING, 0, SCREEN_WIDTH - 2 * PADDING, cell.frame.height)
        if indexPath.row == 4 {
            field.frame.size.width = SCREEN_WIDTH - 2 * PADDING - 80
            signOutBtn = getButton(CGRectMake(SCREEN_WIDTH - 80 - PADDING / 2, 5, 80, cell.frame.height - 10), title: LocalizedString("短信验证"), theme: STYLE_BUTTON_LIGHT)
            signOutBtn.addTarget(self, action: "getCode", forControlEvents: .TouchUpInside)
            cell.contentView.addSubview(signOutBtn)
        }
        cell.contentView.addSubview(field)
        return cell
    }
    
    override func onCreateLoader() -> BaseLoader? {
        let mapping = smartMapping(User.self)
        return HttpLoader(endpoint: getEndpoint("users"), mapping: mapping)
    }
    
    override func onLoadSuccess<E : User>(entity: E) {
        dismissViewControllerAnimated(true, completion: nil)
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
    func create() {
        if phoneField.text!.isEmpty || codeField.text!.isEmpty || newSecuryField.text!.isEmpty || nextSecuryField.text!.isEmpty {
            showAlert(self, title: "请把信息填写完整", message: "")
            
        }
        if newSecuryField.text != nextSecuryField.text {
            showAlert(self, title: "输入的两次密码不一致，请核对后再试", message: "")
        } else {
            RKObjectManager.sharedManager().HTTPClient.setDefaultHeader("Authorization", value: "")
            (loader as! HttpLoader).post(nil, parameters: ["nickname" : nameField.text!, "username" : phoneField.text!, "password" : newSecuryField.text!, "code" : codeField.text!])
        }
    }
    
    func getCode() {
        if phoneField.text?.length != 11 {
            showAlert(self, title: "请填写正确的手机号", message: "")
            return
        }
        let mapping = smartMapping(Sms.self)
        let descriptor = RKResponseDescriptor(mapping: mapping, method: .Any, pathPattern: nil, keyPath: nil, statusCodes: RKStatusCodeIndexSetForClass(.Successful))
        RKObjectManager.sharedManager().HTTPClient.setDefaultHeader("Authorization", value: "")
        RKObjectManager.sharedManager().addResponseDescriptor(descriptor)
        RKObjectManager.sharedManager().postObject(mapping, path: getEndpoint("send_sms"), parameters: ["mobile" : phoneField.text!, "send_verify_code" : "xiaomar_send_sms"], success: { operation, result in
            let getResult = result.firstObject as! Sms
            getResult.code == 0 ? self.waitingCode() : showAlert(self, title: "Error", message: getResult.reason)
            }) { operation, error in
                showAlert(nil, title: "Send SMS Error", message: error.localizedDescription)
        }
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
    
    func agreement() {
        let dest = AboutUs()
        dest.nameString = "agreement"
        dest.titleString = "注册协议"
        navigationController?.pushViewController(dest, animated: true)
    }
}
