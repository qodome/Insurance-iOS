

class CardList: BaseCardList {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(view.frame.width, view.frame.width * 3 / 5 + 88)
        layout.minimumLineSpacing = 0
        (listView as! UICollectionView).collectionViewLayout = layout
        (listView as! UICollectionView).registerClass(CardListCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func getItemView<V : UICollectionView, T : Card, C : CardListCell>(listView: V, indexPath: NSIndexPath, item: T, cell: C) -> UIView {
        cell.image.sd_setImageWithURL(NSURL(string: item.imageUrl as String))
        cell.captionLabel.text = item.caption as String
        cell.setTips(item.tips as String)
        return cell
    }
}
