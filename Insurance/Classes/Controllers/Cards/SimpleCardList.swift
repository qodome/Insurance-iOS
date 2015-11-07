

class SimpleCardList: BaseCardList {
    // MARK: - 🐤 Taylor
    override func onPrepare<T : UICollectionView>(listView: T) {
        super.onPrepare(listView)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(view.frame.width, 80)
        layout.minimumLineSpacing = 1
        listView.collectionViewLayout = layout
        listView.registerClass(CardTableCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func getItemView<V : UICollectionView, T : Card, C : CardTableCell>(listView: V, indexPath: NSIndexPath, item: T, cell: C) -> C {
        cell.image.sd_setImageWithURL(NSURL(string: item.imageUrl))
        cell.captionLabel.text = item.caption
        cell.captionLabel.sizeToFit()
        cell.setTips(item.tips)
        cell.setSite("\(indexPath.row + 1)")
        return cell
    }
}
