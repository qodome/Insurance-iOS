//
//  Copyright © 2015年 NY. All rights reserved.
//

class ProductDetail: GroupedTableDetail {
    var imageView: UIImageView!
    
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        mapping = getDetailMapping(Product.self)
        refreshMode = .DidLoad
        items = [
            [Item(title: "name")],
            [
                Item(title: "price"),
                Item(title: "price"),
//                Item(title: "price"),
//                Item(title: "price"),
//                Item(title: "price"),
//                Item(title: "price"),
//                Item(title: "price"),
//                Item(title: "price"),
//                Item(title: "price"),
//                Item(title: "price"),
//                Item(title: "price"),
                Item(title: "created_time")
            ]]
        imageView = ImageView(frame: CGRectMake(0, 0, view.frame.width, 130))
        tableView.addSubview(imageView)
        let button = getBottomButton(view)
        button.addTarget(self, action: "buy", forControlEvents: .TouchUpInside)
        button.setTitle(LocalizedString("buy"), forState: .Normal)
        view.addSubview(button)
    }
    
    override func onLoadSuccess<E : Product>(entity: E) {
        super.onLoadSuccess(entity)
        imageView.sd_setImageWithURL(NSURL(string: entity.imageUrl))
    }
    
    override func getItemView<T : Product, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        switch item.title {
        case "price":
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            cell.detailTextLabel?.text = formatter.stringFromNumber(NSNumber(double: data.price.doubleValue / 100))
        default: break
        }
        return cell
    }
    
    func buy() {
        performSegueWithIdentifier("segue.product_detail-order_create", sender: self)
    }
    
    override func onSegue(segue: UIStoryboardSegue?, dest: UIViewController, id: String) {
        let product = data as! Product
        let order = Order()
        order.name = product.name
        order.totalFee = product.price
        order.product = product
        dest.setValue(order, forKey: "data")
    }
    
    // MARK: - 💜 UITableViewDelegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? imageView.frame.height : 20
    }
}
