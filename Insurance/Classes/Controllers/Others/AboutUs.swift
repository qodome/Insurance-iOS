//
//  Copyright © 2015年 NY. All rights reserved.
//

class AboutUs: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var url: String!
    var nameString = ""
    var htmlString = ""
    
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: view.frame)
        webView.navigationDelegate = self
        view.addSubview(webView)
        url  = NSBundle.mainBundle().pathForResource(nameString, ofType: "html")
        htmlString = try! String(contentsOfFile: url, encoding: NSUTF8StringEncoding)
        webView.loadHTMLString(htmlString, baseURL: NSURL(string: url))
    }
    
    // MARK: - 💜 WKNavigationDelegate
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.Allow)
    }
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        navigationController?.showProgress()
//        navigationController?.setProgress(CGFloat(2 * webView.estimatedProgress), animated: true)
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
//        navigationController?.finishProgress()
    }
}
