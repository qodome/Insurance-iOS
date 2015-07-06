//
//  Copyright (c) 2014年 NY. All rights reserved.
//

class PageCell: UICollectionViewCell, UIScrollViewDelegate {
    // MARK: - 🍀 变量
    var scrollView: UIScrollView!
    var count = 0
    var page = 0 // 当前处于的页面,默认为0
    
    var canCycle = false // 能否循环
    var canAutoRun: Bool = false { // 能否自动滑动
        didSet {
            if canAutoRun  {
                timerInit()
            } else {
                timer?.invalidate()
                timer = nil
            }
        }
    }
    var isOnAutoRun = false // 是否正处于自动滑动
    var timer: NSTimer? // 计时器(用来控制自动滑动)
    
    // MARK: - 💖 生命周期 (Lifecycle)
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        scrollView = UIScrollView(frame: CGRect(origin: CGPointZero, size: frame.size))
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.userInteractionEnabled = false // 这句和下一句可以让点击响应到父类 ＃SO
        contentView.addGestureRecognizer(scrollView.panGestureRecognizer)
        addSubview(scrollView)
        scrollView.delegate = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        count = 0
        page = 0
        canCycle = false
        canAutoRun = false
        timer?.invalidate() // TODO: 这句和下一句的正确写法
        timer = nil
        let views = scrollView.subviews
        for view in views { // 不移掉的话永远在
            view.removeFromSuperview()
        }
    }
    
    // MARK: - 💜 UIScrollViewDelegate
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if canAutoRun {
            if isOnAutoRun {
                scrollView.contentOffset.x = scrollView.contentOffset.x - scrollView.frame.width
            }
            // 计时器 inValidate
            timer?.invalidate()
            timer = nil
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        if canCycle {
            if scrollView.contentOffset.x == 0.0 {
                scrollView.contentOffset.x = scrollView.frame.width * CGFloat(count - 2)
            }
            if scrollView.contentOffset.x == scrollView.frame.width * CGFloat(count - 1) {
                scrollView.contentOffset.x = scrollView.frame.width
            }
        }
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        // 只有在 currentScrollView.setContentOffset 调用后才被调用
        isOnAutoRun = false
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timerInit()
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func addPage(view: UIView) {
        count++
        scrollView.contentSize = CGSizeMake(scrollView.frame.width * CGFloat(count), scrollView.frame.height)
        scrollView.addSubview(view)
    }
    
    func timerInit() {
        if canAutoRun {
            timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "autoSetCurrentContentOffset", userInfo: nil, repeats: true)
        }
    }
    
    func autoSetCurrentContentOffset() {
        isOnAutoRun = true
        scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x + scrollView.frame.width, y: scrollView.contentOffset.y), animated: true)
    }
}
