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
        items = [[.emptyItem()], [.emptyItem()]]
        for index in 0..<(data as! Offer).insurance_groups.count.integerValue {
            items += [[]]
            for  insurance in ((data as! Offer).insurance_groups.results[index] as! InsuranceGroup).insurances.results {
                items[index + 2] += [Item(title: (insurance as! Insurance).name)]
            }
        }
    }
    
    override func getItemView<T : Offer, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let headFirstCell = OfferDeatilCell(style: .Value1, reuseIdentifier: cellId)
            headFirstCell.setData(data)
            headFirstCell.userInteractionEnabled = false
            return headFirstCell
        case 1:
            let headSecondCell = OfferDeatilHead(style: .Value1, reuseIdentifier: cellId)
            headSecondCell.setData(data)
            headSecondCell.userInteractionEnabled = false
            return headSecondCell
        default:
            cell.detailTextLabel?.text = ((data.insurance_groups.results[indexPath.section - 2]).insurances.results[indexPath.row] as! Insurance).options
        }
        return cell
    }
    
    // MARK: - 💜 UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 {
            let strSize = "\((data as! Offer).remark)".boundingRectWithSize(CGSizeMake(SCREEN_WIDTH - 2 * PADDING, 5000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)], context: nil)
            return 60 + ("\((data as! Offer).remark)" == "" ? -10 : strSize.height)
        }
        return indexPath.section == 0 ? 80 : tableView.rowHeight
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == tableView.numberOfSections - 1 ? BUTTON_HEIGHT : 0
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if data != nil && section > 1 {
            return (data as! Offer).insurance_groups.results[section - 2].name
        }
        return ""
    }
    
    func create() {
        let mapping = smartMapping(Order.self)
        let descriptor = RKResponseDescriptor(mapping: mapping, method: .Any, pathPattern: nil, keyPath: nil, statusCodes: RKStatusCodeIndexSetForClass(.Successful))
        RKObjectManager.sharedManager().addResponseDescriptor(descriptor)
        RKObjectManager.sharedManager().postObject(mapping, path: getEndpoint("orders"), parameters: ["phone_number" : (data as! Offer).phoneNumber, "product_id" : "1", "car_license_number" : (data as! Offer).carLicenseNumber, "offer_id" : (data as! Offer).id], success: { operation, result in
            NSNotificationCenter.defaultCenter().postNotificationName("changeIndex", object: ["id": "\((result.firstObject as! Order).id)", "index": "3"])
            self.cancel()
            }) { operation, error in
                showAlert(self, title: "订单生成失败", message: error.localizedDescription)
        }
    }
}
