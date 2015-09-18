# Insurance

因为微信SDK不支持暂时关闭bitcode

注意
----
Swift稍复杂数组会大幅降低XCode编译速度
禁用UITableView选择 tableView.allowsSelection = false
TIP: 标签为要注意的地方

Emoji
-----
🍀 变量
💖 生命周期 (Lifecycle)
💜 继承系统方法
💙 三方库方法
💛 自定义方法

命名规则
-------

Segue
-----
segue.from_list-to_detail

UIControl
---------
xxxField TextField

### via [Alcatraz](http://alcatraz.io/) Shift+Command+9
多语言工具 [Lin](http://questbe.at/lin/)
自定义
1. Open `~/Library/Application Support/Developer/Shared/Xcode/Plug-ins/Lin.xcplugin/Contents/Resources/Completions.plist`
2. Add
```
<dict>
<key>LINFunctionName</key>
<string>LocalizedString</string>
<key>LINKeyCompletionPatterns</key>
<array>
<dict>
<key>Objective-C</key>
<string>LocalizedString\s*\(\s*(\w*)</string>
<key>Swift</key>
<string>LocalizedString\s*\(\s*(\w*)</string>
</dict>
</array>
</dict>
```
