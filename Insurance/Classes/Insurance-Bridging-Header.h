#import <CommonCrypto/CommonDigest.h>
#import <CoreLocation/CoreLocation.h>
#import <Photos/Photos.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

// CTAssetsPickerController https://github.com/chiunam/CTAssetsPickerController
#import <CTAssetsPickerController/CTAssetsPickerController.h>

// DateTools https://github.com/MatthewYork/DateTools
#import <DateTools/DateTools.h>

// EAIntroView https://github.com/ealeksandrov/EAIntroView
#import <EAIntroView/EAIntroView.h> 

// FontAwesomeKit https://github.com/PrideChung/FontAwesomeKit
#import <FontAwesomeKit/FontAwesomeKit.h>

// FormatterKit https://github.com/mattt/FormatterKit
#import <FormatterKit/TTTTimeIntervalFormatter.h>

// M13ProgressSuite https://github.com/Marxon13/M13ProgressSuite
#import <M13ProgressSuite/M13ProgressHUD.h>
#import <M13ProgressSuite/M13ProgressViewLetterpress.h>
#import <M13ProgressSuite/M13ProgressViewRing.h>
#import <M13ProgressSuite/M13ProgressViewPie.h>
#import <M13ProgressSuite/UINavigationController+M13ProgressViewBar.h>

// RestKit https://github.com/RestKit/RestKit
#if __IPHONE_OS_VERSION_MIN_REQUIRED
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>
#else
#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreServices/CoreServices.h>
#endif

#import <RestKit/RestKit.h>

// SDWebImage https://github.com/rs/SDWebImage
#import <SDWebImage/UIImageView+WebCache.h>

// SZTextView https://github.com/glaszig/SZTextView
#import <SZTextView/SZTextView.h>

// TLYShyNavBar https://github.com/telly/TLYShyNavBar
#import <TLYShyNavBar/TLYShyNavBarManager.h>

// 💙 TSMessages https://github.com/KrauseFx/TSMessages
#import <TSMessages/TSMessage.h>

// WeiboSDK https://github.com/sinaweibosdk/weibo_ios_sdk/
#import <WeiboSDK/WeiboSDK.h>

// Weixin https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list
#import <Weixin/WXApi.h>

#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif
