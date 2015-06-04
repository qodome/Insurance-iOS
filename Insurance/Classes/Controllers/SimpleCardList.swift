

class SimpleCardList: BaseCardList {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(view.frame.width, 80)
        layout.minimumLineSpacing = 1
        (listView as! UICollectionView).collectionViewLayout = layout
        (listView as! UICollectionView).registerClass(CardTableCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func getItemView<V : UICollectionView, T : Card, C : CardTableCell>(listView: V, indexPath: NSIndexPath, item: T, cell: C) -> UIView {
        cell.image.sd_setImageWithURL(NSURL(string: item.imageUrl as String))
        cell.captionLabel.text = item.caption as String
        cell.captionLabel.sizeToFit()
        cell.setTips(item.tips as String)
        cell.setSite("\(indexPath.row + 1)")
        return cell
    }
}
