//
//  Copyright © 2015年 NY. All rights reserved.
//

class Home: MyList {
    
    let pageCellId = "page_list_cell"
    
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
    override func onPrepare<T : UICollectionView>(listView: T) {
        super.onPrepare(listView)
        endpoint = getEndpoint("home")
        mapping = getListMapping(Card.self, children: [RKChild(path: "user", type: User.self), RKChild(path: "comments", type: Comment.self, isList: true), RKChild(path: "likes", type: Like.self, isList: true)], rootType: HomeModel.self)
        mapping!.addRelationshipMappingWithSourceKeyPath("featured", mapping: getListMapping(Featured.self))
        mapping!.addRelationshipMappingWithSourceKeyPath("specials", mapping: getListMapping(Special.self, children: [RKChild(path: "cards", type: Card.self, isList: true)]))
        refreshMode = .WillAppear
        listView.registerClass(CardCell.self, forCellWithReuseIdentifier: cellId)
        listView.registerClass(PageCell.self, forCellWithReuseIdentifier: pageCellId)
        // 开机画面
        launchView = UIImageView(frame: view.bounds)
        launchView.hidden = true
        launchView.image = UIImage(named: "op0")
        UIApplication.sharedApplication().keyWindow?.addSubview(launchView)
        //        UIView.animateWithDuration(2, animations: {
        //            self.launchView.transform = CGAffineTransformScale(self.launchView.transform, 1.2, 1.2)
        //        })
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "hiddenBgview",
            userInfo: nil, repeats: false)
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
    
    override func onPerform<T : ModelObject>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            let cell = (listView as! UICollectionView).cellForItemAtIndexPath(indexPath) as! PageCell
            selected = getSelected(indexPath, page: cell.page)
            if selected.isMemberOfClass(Card) {
                if (selected as! Card).type == "p" {
                    startActivity(Item(title: "product", dest: ProductDetail.self))
                } else {
                    // startActivity(Item(title: "cards/:pk", dest: CardWebDetail.self))
                }
            } else if selected.isMemberOfClass(Special) {
                destEndpoint = getEndpoint("specials/\((selected as! Special).id)")
                startActivity(Item(title: "cards", dest: CardList.self))
            } else if selected.isMemberOfClass(Featured) {
                switch (selected as! Featured).type {
                case "c":
                    startActivity(Item(title: "cards/:pk", dest: CardWebDetail.self))
                case "s":
                    destEndpoint = getEndpoint("specials/\((selected as! Featured).objectId)")
                    startActivity(Item(title: "cards", dest: CardList.self))
                default: break
                }
            }
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
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
            for (i, featured) in list.enumerate() {
                let view: PosterView
                if (remainder + featuredCellCount) % 2 == 0 {
                    view = SpecialCover(frame: CGRectMake(CGFloat(i) * width, 0, width, height))
                    (view as! SpecialCover).changeSubtitle(featured.summary)
                } else {
                    view = PosterView(frame: CGRectMake(CGFloat(i) * width, 0, width, height))
                }
                view.image.sd_setImageWithURL(NSURL(string: featured.imageUrl))
                view.changeTitle(featured.title)
                cell.addPage(view)
            }
            if list.count > 1 {
                cell.scrollView.contentOffset.x = cell.scrollView.frame.width
            }
        } else if remainder == 0 && quotient < specialList.count {
            let special = specialList[quotient]
            let view = SpecialCover(frame: CGRectMake(0, 0, width, height))
            view.image.sd_setImageWithURL(NSURL(string: special.imageUrl))
            view.changeTitle(special.title)
            view.changeSubtitle("\(special.cards.count)个主题")
            view.changeSubtitleBackground(.colorWithHex(0xB4A66F))
            cell.addPage(view)
            for (i, card) in (special.cards.results as! [Card]).enumerate() {
                let view = CardView(frame: CGRectMake(CGFloat(i + 1) * width, 0, width, height))
                view.title.text = card.caption
                view.subtitle.text = [getType(card.type), "\(card.likes.count) 喜欢"].joinWithSeparator(" · ")
                view.image.sd_setImageWithURL(NSURL(string: card.imageUrl))
                view.icon.image = UIImage(named: "ferrari")
                cell.addPage(view)
            }
        } else { // 不考虑卡片不到专题两倍造成的出错情况
            let item = getItem(indexPath.row - featuredCellCount - min(specialList.count, quotient + 1)) as! Card
            cell = getCardCell(item, cell: collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! CardCell)
        }
        return cell
    }
    
    // MARK: - 场景切换 (Segue)
    override func onSegue(segue: UIStoryboardSegue?, dest: UIViewController, id: String) {
        LOG("💜 \(id)")
        switch id {
        case "card_list":
            if selected.isMemberOfClass(Special) {
                dest.title = (selected as! Special).title
                dest.setValue((selected as! Special).cards, forKey: "data")
            }
            dest.setValue(destEndpoint, forKey: "endpoint")
            dest.setValue("cards", forKey: "keyPath")
        case "card_detail":
            if selected.isMemberOfClass(Featured) {
                dest.setValue("\((selected as! Featured).objectId)", forKey: "pk")
            } else {
                dest.setValue(selected, forKey: "data")
                dest.setValue((selected as! Card).idStr, forKey: "pk")
            }
        case "product_detail":
            dest.setValue(getEndpoint("products/\((selected as! Card).objectId)"), forKey: "endpoint")
        default: break
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
