//
//  Copyright © 2015年 NY. All rights reserved.
//

class SignIn: SignInController {
    
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        let buttonName = ["register", "securyback"]
        for (index, value) in buttonName.enumerate() {
            let width = (view.frame.width - PADDING * 2 - PADDING_INNER) / 2
            let button = QuickButton(frame: CGRectMake(PADDING + (width
                + PADDING_INNER) * CGFloat(index),  CGRectGetMaxY(signInButton.frame) + PADDING_INNER, width, BUTTON_HEIGHT), title: LocalizedString(value), theme: STYLE_BUTTON_LIGHT)
            button.addTarget(self, action: index == 0 ? "register" : "securyback", forControlEvents: .TouchUpInside)
            tableView.addSubview(button)
        }
    }
    
    override func onLoadFailure(statusCode: Int, message: String) {
        if message == "{\"non_field_errors\":[\"Unable to login with provided credentials.\"]}" {
            showAlert(self, message: "账号和密码不匹配。")
        } else {
            super.onLoadFailure(statusCode, message: message)
        }
    }
    
    // MARK: - 💛 Action
    func register() {
        startActivity(Item(dest: Register.self, storyboard: false))
    }
    
    func securyback() {
        startActivity(Item(dest: SecuryBack.self, storyboard: false))
    }
}
