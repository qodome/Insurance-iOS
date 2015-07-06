//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class MyList: CollectionList {
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        // 颜色
        listView.backgroundColor = UIColor.colorWithHex(BACKGROUND_COLOR)
        //绑定 layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(view.frame.width, view.frame.width * 0.9)
        layout.minimumLineSpacing = 0
        (listView as! UICollectionView).collectionViewLayout = layout
    }
}
