//
//  Copyright © 2015年 NY. All rights reserved.
//

class Province: ModelObject {
    var name = ""
    var code: NSNumber!
    var state: NSNumber!
    var cities = [Province]()
}
