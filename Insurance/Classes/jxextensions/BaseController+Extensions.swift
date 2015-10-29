//
//  Copyright © 2015年 NY. All rights reserved.
//

extension BaseController {
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func returnAddressWithLatAndlng(lat: Double, lng: Double) -> NSDictionary {
        let cityRequest = NSURLRequest(URL: NSURL(string: "http://api.map.baidu.com/geocoder?location=\(lat),\(lng)&output=json")!)
        let requestData = try! NSURLConnection.sendSynchronousRequest(cityRequest, returningResponse: nil)
        let cityInfo = try! NSJSONSerialization.JSONObjectWithData(requestData, options: .MutableContainers) as! NSDictionary
        return cityInfo
    }
    
    // 压缩照片的方法
    func normalResImageForAsset(pickerimage: UIImage) -> UIImage {
        let image = pickerimage
        let maxSize = CGFloat(1024.0)
        let width = image.size.width
        let height = image.size.height
        var newWidth = width
        var newHeight = height
        if width > maxSize || height > maxSize {
            if width > height {
                newWidth = maxSize
                newHeight = (height * maxSize) / width
            }else {
                newHeight = maxSize
                newWidth = (width * maxSize) / height
            }
        }
        let newSize = CGSizeMake(newWidth, newHeight)
        UIGraphicsBeginImageContext(newSize)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageData = UIImageJPEGRepresentation(newImage, 0.6)!
        return UIImage(data: imageData)!
    }
    
    func getStatusDic() -> NSDictionary {
        let jsonData = try! String(contentsOfFile: NSBundle.mainBundle().pathForResource("statues", ofType: "json")!, encoding: NSUTF8StringEncoding).dataUsingEncoding(NSUTF8StringEncoding)
        let temp = try! NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers) as! NSDictionary
        return temp
    }
}
