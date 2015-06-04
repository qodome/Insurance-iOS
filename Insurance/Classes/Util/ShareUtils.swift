//
//  Copyright (c) 2015年 NY. All rights reserved.
//

func startShareActivity(controller: UIViewController, items: [AnyObject], view: UIView?) {
    let dest = UIActivityViewController(activityItems: items, applicationActivities: nil)
    dest.excludedActivityTypes = [
        "com.tumblr.tumblr.Share-With-Tumblr", // 8.1之后失效 http://johnszumski.com/blog/excluding-third-party-apps-from-ios-8-share-sheet
        UIActivityTypePostToFacebook,
        UIActivityTypeMessage, UIActivityTypeMail,
        UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact,
        UIActivityTypeSaveToCameraRoll, // 系统自动只能存五张效果不好所以去除
        UIActivityTypeAddToReadingList,
        UIActivityTypePostToFlickr, UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo,
        UIActivityTypeAirDrop]
    // http://stackoverflow.com/questions/25644054/uiactivityviewcontroller-crashing-on-ios8-ipads
    if dest.respondsToSelector("popoverPresentationController") { // 兼容iPad
        if view != nil {
            dest.popoverPresentationController?.sourceView = view
            dest.popoverPresentationController?.sourceRect = CGRectMake(view!.frame.width / 2, 0, 0, 0)
        } else {
            dest.popoverPresentationController?.sourceView = controller.view
            dest.popoverPresentationController?.sourceRect = CGRectMake(0, 0, controller.view.frame.width, controller.view.frame.height / 2)
        }
    }
    controller.presentViewController(dest, animated: true, completion: nil)
}
