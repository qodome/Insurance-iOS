//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class Home: MyList {
    
    let pageCellId = "page_list_cell"
    
    let SEGUE_CARD_LIST = "segue.home-card_list"
    let SEGUE_CARD_DETAIL = "segue.home-card_detail"
    
    var featuredCellCount = 0
    var featuredList: [[Featured]] = [[]]
    var specialList: [Special] = []
    
    var destEndpoint = ""
    
    var launchView: UIImageView!
    
    func hiddenBgview() {
        launchView.hidden = true
        launchView = nil
    }
    
    var selected: AnyObject!
    
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.translucent = true // 恢复默认值
        extendedLayoutIncludesOpaqueBars = false
    }
    
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        endpoint = getEndpoint("home")
        refreshMode = .WillAppear
        (listView as! UICollectionView).registerClass(CardCell.self, forCellWithReuseIdentifier: cellId)
        (listView as! UICollectionView).registerClass(PageCell.self, forCellWithReuseIdentifier: pageCellId)
        // 其他
        UIView.setAnimationsEnabled(true) // 从登陆跳转过来后恢复动画
        // 开机画面
        launchView = UIImageView(frame: view.bounds)
        launchView.hidden = true
        launchView.image = UIImage(named: "op0")
        UIApplication.sharedApplication().keyWindow?.addSubview(launchView)
        //        UIView.animateWithDuration(2, animations: {
        //            self.launchView.transform = CGAffineTransformScale(self.launchView.transform, 1.2, 1.2)
        //        })
        var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "hiddenBgview",
            userInfo: nil, repeats: false)
    }
    
    override func onCreateLoader() -> BaseLoader {
        let mapping = smartListMapping(Card.self, children: ["user" : User.self, "comments" : ListModel.self, "likes" : ListModel.self], rootType: HomeModel.self)
        mapping.addRelationshipMappingWithSourceKeyPath("featured", mapping: smartListMapping(Featured.self))
        mapping.addRelationshipMappingWithSourceKeyPath("specials", mapping: smartListMapping(Special.self, children: ["cards" : ListModel.self]))
        return HttpLoader(endpoint: endpoint, mapping: mapping)
    }
    
    override func onLoadSuccess<E : HomeModel>(entity: E) {
        let size = 5 // 每行精选个数
        featuredList.removeAll(keepCapacity: true)
        featuredCellCount = (entity.featured.count.integerValue + size - 1) / size // 进位除法
        for i in 0..<featuredCellCount {
            let count = i == featuredCellCount - 1 ? entity.featured.count.integerValue - i * size : size // 每行个数
            featuredList += [[]]
            if count > 1 { // 如果多于一个，添加头尾
                featuredList[i] += [entity.featured.results[count - 1] as! Featured]
            }
            for j in 0..<count {
                featuredList[i] += [entity.featured.results[j] as! Featured]
            }
            // featuredList[i] += entity.featured.results[0...count - 1] as! [Featured]
            if count > 1 {
                featuredList[i] += [entity.featured.results[0] as! Featured]
            }
        }
        specialList = entity.specials.results as! [Special]
        super.onLoadSuccess(entity)
    }
    
    // MARK: - 💜 UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getCount() + specialList.count + featuredCellCount
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        loadMore(collectionView, indexPath: indexPath) // 下一页
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(pageCellId, forIndexPath: indexPath) as! PageCell
        let width = cell.frame.width
        let height = cell.frame.height
        let quotient = (indexPath.row - featuredCellCount) / 3
        let remainder = (indexPath.row - featuredCellCount) % 3
        if remainder < 0 {
            let list = featuredList[remainder + featuredCellCount]
            cell.canCycle = true
            cell.canAutoRun = remainder == -featuredCellCount && list.count > 1
            for i in 0..<list.count {
                var view: PosterView
                if (remainder + featuredCellCount) % 2 == 0 {
                    view = SpecialCover(frame: CGRectMake(CGFloat(i) * width, 0, width, height))
                    (view as! SpecialCover).changeSubtitle(list[i].summary as String)
                } else {
                    view = PosterView(frame: CGRectMake(CGFloat(i) * width, 0, width, height))
                }
                view.image.sd_setImageWithURL(NSURL(string: list[i].imageUrl as String))
                view.changeTitle(list[i].title as String)
                cell.addPage(view)
            }
            if list.count > 1 {
                cell.scrollView.contentOffset.x = cell.scrollView.frame.width
            }
        } else if remainder == 0 && quotient < specialList.count {
            let special = specialList[quotient]
            let view = SpecialCover(frame: CGRectMake(0, 0, width, height))
            view.image.sd_setImageWithURL(NSURL(string: special.imageUrl as String))
            view.changeTitle(special.title as String)
            view.changeSubtitle("\(special.cards.count)个主题")
            view.changeSubtitleBackground(UIColor.colorWithHex(0xB4A66F))
            cell.addPage(view)
            for i in 0..<special.cards.count.integerValue {
                let card = special.cards.results[i] as! Card
                let view = CardView(frame: CGRectMake(CGFloat(i + 1) * width, 0, width, height))
                view.title.text = card.caption as String
                view.subtitle.text = " · ".join([getType(card.type as String), "\(card.likes.count) 喜欢"])
                // view.subtitle.text = " · ".join([getType(card.type as String), "\(card.likeCount) 喜欢", card.tags])
                view.image.sd_setImageWithURL(NSURL(string: card.imageUrl as String))
                view.icon.image = UIImage(named: "ferrari")
                cell.addPage(view)
            }
        } else { // 不考虑卡片不到专题两倍造成的出错情况
            let item = getItem(indexPath.row - featuredCellCount - min(specialList.count, quotient + 1)) as! Card
            cell = getCardCell(item, collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! CardCell)
        }
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PageCell
        selected = getSelected(indexPath, page: cell.page)
        if selected.isKindOfClass(Card) {
//            performSegueWithIdentifier(SEGUE_CARD_DETAIL, sender: self)
        } else if selected.isKindOfClass(Special) {
            destEndpoint = getEndpoint("specials/\((selected as! Special).id)")
            performSegueWithIdentifier(SEGUE_CARD_LIST, sender: self)
        } else if selected.isKindOfClass(Featured) {
            switch (selected as! Featured).type {
            case "c":
                performSegueWithIdentifier(SEGUE_CARD_DETAIL, sender: self)
            case "s":
                destEndpoint = getEndpoint("specials/\((selected as! Featured).objectId)")
                performSegueWithIdentifier(SEGUE_CARD_LIST, sender: self)
            default: break
            }
        }
    }
    
    // MARK: - 💜 场景切换 (Segue)
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        let dest = segue.destinationViewController as! UIViewController
        if segue.identifier == SEGUE_CARD_LIST {
            if selected.isKindOfClass(Special) {
                dest.setValue((selected as! Special).title, forKey: "title")
                dest.setValue((selected as! Special).cards, forKey: "data")
            }
            dest.setValue(destEndpoint, forKey: "endpoint")
            dest.setValue("cards", forKey: "keyPath")
        } else if segue.identifier == SEGUE_CARD_DETAIL {
            if selected.isKindOfClass(Featured) {
                dest.setValue("\((selected as! Featured).objectId)", forKey: "pk")
            } else {
                dest.setValue(selected, forKey: "data")
                dest.setValue((selected as! Card).idStr, forKey: "pk")
            }
        }
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func getSelected(indexPath: NSIndexPath, page: Int) -> AnyObject {
        let quotient = (indexPath.row - featuredCellCount) / 3
        let remainder = (indexPath.row - featuredCellCount) % 3
        if remainder < 0 {
            return featuredList[remainder + featuredCellCount][page]
        } else if remainder == 0 && quotient < specialList.count {
            return page == 0 ? specialList[quotient] : specialList[quotient].cards.results[page - 1]
        } else {
            return getItem(indexPath.row - featuredCellCount - min(specialList.count, quotient + 1))
        }
    }
}
