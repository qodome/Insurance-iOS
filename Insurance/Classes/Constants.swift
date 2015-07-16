//
//  Copyright (c) 2015年 NY. All rights reserved.
//

let APP_ID = "981373001" // "https://itunes.apple.com/cn/app/id981373001"

let DOMAIN = "xiaomar.com"

let API_VERSION = "api/v1"

let DEFAULT_TOKEN = "d55c45f1b33d0617fc3212657e36be1abf2e0a71"

var BASE_URL = "http://\(DOMAIN)"
var MEDIA_URL = "http://media.\(DOMAIN)"

// 样式
let XIAOMAR_RED = 0xFC2C28 // 0xFF2819
let XIAOMAR_YELLOW = 0xFDB333 // 0xFFB419
let XIAOMAR_BLUE = 0x1FBEDF // 0x00BEE1

let XIAOMAR_GREEN = 0x44DB5E

let APP_COLOR = XIAOMAR_RED
let BACKGROUND_COLOR = 0xF5F5F5
let PRIMARY_TEXT_COLOR = 0x333333
let SECONDARY_TEXT_COLOR = 0x565A5C

enum Color: Int {
    case XiaomarRed = 0xFC2C28 // 0xFF2819
    case XiaomarYellow = 0xFDB333 // 0xFFB419
}

let GENDER_STRING = [
    "m" : LocalizedString("male"),
    "f" : LocalizedString("female")
]
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
        MEDIA_URL = "http://test1.media.\(DOMAIN)"
        // 微信
        WX_NOTIFY_URL = "http://qodome.com.cn/api/v1/check_sign/"
    } else {
        BASE_URL = "http://\(DOMAIN)"
        MEDIA_URL = "http://media.\(DOMAIN)"
        // 微信
        WX_NOTIFY_URL = "http://qodome.com.cn/api/v1/check_sign/"
    }
    RKObjectManager.setSharedManager(RKObjectManager(baseURL: NSURL(string: BASE_URL)))
    putBool("test_env", TestEnv)
}
