//
//  Copyright © 2015年 NY. All rights reserved.
//

class AboutUs: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var backButton: UIBarButtonItem!
    var forwardButton: UIBarButtonItem!
    var refreshButton: UIBarButtonItem!
    var url: String!
    var titleString = ""
    var nameString = ""
    var htmlString = ""
    
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizedString(titleString)
        navigationController?.toolbarHidden = false
        webView = WKWebView(frame: view.frame)
        webView.navigationDelegate = self
        view.addSubview(webView)
        url  = NSBundle.mainBundle().pathForResource(nameString, ofType: "html")
        htmlString = try! String(contentsOfFile: url, encoding: NSUTF8StringEncoding)
        backButton = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .Plain, target: self, action: "back")
        forwardButton = UIBarButtonItem(image: UIImage(named: "ic_forward"), style: .Plain, target: self, action: "forward")
        refreshButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refresh")
        setToolbarItems([FLEXIBLE_SPACE, backButton, FLEXIBLE_SPACE, forwardButton, FLEXIBLE_SPACE, refreshButton], animated: false)
        webView.loadHTMLString(htmlString, baseURL: NSURL(string: url))
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.toolbarHidden = true
    }
    
    // MARK: - 💛 Action
    func back() {
        webView.goBack()
    }
    
    func forward() {
        webView.goForward()
    }
    
    func refresh() {
        webView.loadHTMLString(htmlString, baseURL: NSURL(string: url))
    }
    
    // MARK: - 💜 WKNavigationDelegate
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.Allow)
    }
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        backButton.enabled = webView.canGoBack
        forwardButton.enabled = webView.canGoForward
        navigationController?.showProgress()
        navigationController?.setProgress(CGFloat(2 * webView.estimatedProgress), animated: true)
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        backButton.enabled = webView.canGoBack
        forwardButton.enabled = webView.canGoForward
        navigationController?.finishProgress()
    }
}
