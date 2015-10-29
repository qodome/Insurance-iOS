//
//  Copyright © 2015年 NY. All rights reserved.
//

class Freedom: ModelObject {
    var tid = ""
    var name = ""
    var label = ""
    var accessory_type = ""
    var switch_enable = ""
    var switch_status = ""
    var picker_pid = ""
    var picker_array: [PickerModel] = []
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
}
