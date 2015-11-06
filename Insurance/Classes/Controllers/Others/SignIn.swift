//
//  Copyright © 2015年 NY. All rights reserved.
//

class SignIn: SignInController {
    
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        let buttonName = ["register", "securyback"]
        for (index, value) in buttonName.enumerate() {
            let button = getButton(CGRectMake(PADDING + ((SCREEN_WIDTH - 3 * PADDING) / 2 + PADDING) * CGFloat(index),  CGRectGetMaxY(signInButton.frame) + PADDING_INNER, (SCREEN_WIDTH - 2 * PADDING - PADDING_INNER) / 2, BUTTON_HEIGHT), title: LocalizedString(value), theme: STYLE_BUTTON_LIGHT)
            button.addTarget(self, action: index == 0 ? "register" : "securyback", forControlEvents: .TouchUpInside)
            tableView.addSubview(button)
        }
    }
    
    // MARK: - 💛 Action
    func register() {
        startActivity(Item(title: "", dest: Register.self, storyboard: false))
    }
    
    func securyback() {
        startActivity(Item(title: "", dest: SecuryBack.self, storyboard: false))
    }
}
