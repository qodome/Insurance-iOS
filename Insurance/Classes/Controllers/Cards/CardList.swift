

class CardList: BaseCardList {
    // MARK: - 🐤 Taylor
    override func onPrepare<T : UICollectionView>(listView: T) {
        super.onPrepare(listView)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(view.frame.width, view.frame.width * 3 / 5 + 88)
        layout.minimumLineSpacing = 0
        listView.collectionViewLayout = layout
        listView.registerClass(CardListCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func getItemView<V : UICollectionView, T : Card, C : CardListCell>(listView: V, indexPath: NSIndexPath, item: T, cell: C) -> C {
        cell.image.sd_setImageWithURL(NSURL(string: item.imageUrl))
        cell.captionLabel.text = item.caption
        cell.setTips(item.tips)
        return cell
    }
}
