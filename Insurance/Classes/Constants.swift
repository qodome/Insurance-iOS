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

var TestEnv = getBool("test_env", defaultValue: false)

func reloadSettings() {
    if TestEnv {
        BASE_URL = "http://test1.\(DOMAIN)"
        MEDIA_URL = "http://test1.media.\(DOMAIN)"
    } else {
        BASE_URL = "http://\(DOMAIN)"
        MEDIA_URL = "http://media.\(DOMAIN)"
    }
    RKObjectManager.setSharedManager(RKObjectManager(baseURL: NSURL(string: BASE_URL)))
    putBool("test_env", TestEnv)
}
