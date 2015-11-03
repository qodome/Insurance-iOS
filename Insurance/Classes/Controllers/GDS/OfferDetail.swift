//
//  Copyright © 2015年 NY. All rights reserved.
//

class OfferDetail: GroupedTableDetail {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        let button = getBottomButton(view)
        button.addTarget(self, action: "create", forControlEvents: .TouchUpInside)
        button.setTitle(LocalizedString("confirm_orders"), forState: .Normal)
        view.addSubview(button)
        items = [[.emptyItem()]]
        for index in 0..<(data as! Offer).insurance_groups.count.integerValue {
            items += [[]]
            for  insurance in ((data as! Offer).insurance_groups.results[index] as! InsuranceGroup).insurances.results {
                items[index + 1] += [Item(title: (insurance as! Insurance).name)]
            }
        }
    }
    
    override func getItemView<T : Offer, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        if indexPath.section == 0 {
            let headViewCell = OfferDeatilHead(style: .Value1, reuseIdentifier: cellId)
            headViewCell.setData(data)
            headViewCell.userInteractionEnabled = false
            return headViewCell
        } else {
            cell.detailTextLabel?.text = ((data.insurance_groups.results[indexPath.section - 1]).insurances.results[indexPath.row] as! Insurance).options
        }
        return cell
    }
    
    // MARK: - 💜 UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.section == 0 ? 80 : tableView.rowHeight
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == tableView.numberOfSections - 1 ? BUTTON_HEIGHT : 0
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if data != nil && section != 0 {
            return (data as! Offer).insurance_groups.results[section - 1].name
        }
        return ""
    }
    
    func create() {
        let mapping = smartMapping(Order.self)
        let descriptor = RKResponseDescriptor(mapping: mapping, method: .Any, pathPattern: nil, keyPath: nil, statusCodes: RKStatusCodeIndexSetForClass(.Successful))
        RKObjectManager.sharedManager().addResponseDescriptor(descriptor)
        RKObjectManager.sharedManager().postObject(mapping, path: getEndpoint("orders"), parameters: ["product_id" : "1", "car_license_number" : (data as! Offer).carLicenseNumber, "offer_id" : (data as! Offer).id], success: { operation, result in
            NSNotificationCenter.defaultCenter().postNotificationName("changeIndex", object: ["id": "\((result.firstObject as! Order).id)", "index": "3"])
            self.cancel()
            }) { operation, error in
                showAlert(self, title: "订单生成失败", message: error.localizedDescription)
        }
    }
}
