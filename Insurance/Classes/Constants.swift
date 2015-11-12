//
//  Copyright © 2015年 NY. All rights reserved.
//

let APP_ID = "981373001" // "https://itunes.apple.com/cn/app/id981373001"

let DOMAIN = "xiaomar.com"
let API_VERSION = "api/v1"

var BASE_URL = "http://\(DOMAIN)"
var MEDIA_URL = "http://media.\(DOMAIN)"

var DEFAULT_TOKEN = ""
// 微信
let WX_APP_ID = "wxd9d42bf22bc2c7e8"
let WX_SECRET = "96ecd74ae753e0bdb0ebe017ce2d2663"
let WX_MCH_ID = "1249194301"
let WX_SP_KEY = "AB7F441A742AFC4B65824C05EAF79B76"
var WX_NOTIFY_URL = ""
// 微博
let WB_APP_KEY = ""

var TestEnv = getBool("test_env", defaultValue: false)

func reloadSettings() {
    if TestEnv { // 测试环境
        BASE_URL = "http://test1.\(DOMAIN)"
        MEDIA_URL = "http://test.media.\(DOMAIN)"
        DEFAULT_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo5LCJlbWFpbCI6IiIsImV4cCI6MTQzODQyMTcyNywib3JpZ19pYXQiOjE0MzcxMjU3MjcsInVzZXJuYW1lIjoidGVzdCJ9.-PVwOX1JkQcP3tzoqpI-g56qwQnEaXkBxjjXG9WQ75w"
    } else {
        BASE_URL = "http://\(DOMAIN)"
        MEDIA_URL = "http://media.\(DOMAIN)"
        DEFAULT_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo5LCJlbWFpbCI6IiIsImV4cCI6MTQzODQyMTcyNywib3JpZ19pYXQiOjE0MzcxMjU3MjcsInVzZXJuYW1lIjoidGVzdCJ9.-PVwOX1JkQcP3tzoqpI-g56qwQnEaXkBxjjXG9WQ75w"
    }
    // 微信
    WX_NOTIFY_URL = "\(BASE_URL)/api/v1/check_sign/"
    //
    RKObjectManager.setSharedManager(RKObjectManager(baseURL: NSURL(string: BASE_URL)))
    putBool("test_env", value: TestEnv)
}

// 样式
let XIAOMAR_RED = 0xFC2C28 // 0xFF2819
let XIAOMAR_YELLOW = 0xFDB333 // 0xFFB419
let XIAOMAR_BLUE = 0x1FBEDF // 0x00BEE1

let XIAOMAR_GREEN = 0x44DB5E

let APP_COLOR = XIAOMAR_RED
let BACKGROUND_COLOR = 0xF5F5F5
let PRIMARY_TEXT_COLOR = 0x333333
let SECONDARY_TEXT_COLOR = 0x565A5C

let BUTTON_HEIGHT: CGFloat = 48

enum Color: Int {
    case XiaomarRed = 0xFC2C28 // 0xFF2819
    case XiaomarYellow = 0xFDB333 // 0xFFB419
}

enum Style: Int {
    case Light, Dark
}

class Theme {
    var color: Int!
    var alpha: CGFloat!
    var style: Style!
    
    init(style: Style = .Dark, color: Int = APP_COLOR, alpha: CGFloat = 1) {
        self.style = style
        self.color = color
        self.alpha = alpha
    }
}

let STYLE_BUTTON_DARK = Theme(alpha: 0.7)
let STYLE_BUTTON_LIGHT = Theme(style: .Light)

let GENDER_STRING = [
    "m" : "male",
    "f" : "female"
]
