//
//  Copyright © 2015年 NY. All rights reserved.
//

class MyList: CollectionList {
    // MARK: - 🐤 继承 Taylor
    override func onPrepare<T : UICollectionView>(listView: T) {
        super.onPrepare(listView)
        // 颜色
        listView.backgroundColor = UIColor.colorWithHex(BACKGROUND_COLOR)
        //绑定 layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(view.frame.width, view.frame.width * 0.9)
        layout.minimumLineSpacing = 0
        listView.collectionViewLayout = layout
    }
}
