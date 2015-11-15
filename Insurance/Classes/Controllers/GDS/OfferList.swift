//
//  Copyright © 2015年 NY. All rights reserved.
//

class OfferList: TableList {
    let headLabel = UILabel()
    
    // MARK: - 🐤 Taylor
    override func setTableViewStyle() -> UITableViewStyle {
        return .Grouped
    }
    
    override func onPrepare<T : UITableView>(listView: T) {
        super.onPrepare(listView)
        mapping = smartMapping(ListModel.self)
//        let offerMapping = smartMapping(Offer.self, children: ["brand" : Brand.self])
//        let agentMapping = smartMapping(Branch.self, children: ["credit" : BusinessCredit.self])
//        agentMapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "tags", toKeyPath: "tags", withMapping: smartListMapping(Tag.self)))
//        offerMapping.addRelationshipMappingWithSourceKeyPath("agent", mapping: agentMapping)
//        let groupMapping = smartMapping(ListModel.self)
//        let groupNext = smartMapping(InsuranceGroup.self)
//        groupNext.addRelationshipMappingWithSourceKeyPath("insurances", mapping: smartListMapping(Insurance.self))
//        groupMapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "results", toKeyPath: "results", withMapping: groupNext))
//        offerMapping.addRelationshipMappingWithSourceKeyPath("insurance_groups", mapping: groupMapping)
//        mapping!.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "results", toKeyPath: "results", withMapping: offerMapping))
        listView.registerClass(OfferListCell.self, forCellReuseIdentifier: cellId)
        let brandView = UIView(frame: CGRectMake(0, 0 , view.frame.width, 35))
        headLabel.frame = CGRectMake(10, 0 , view.frame.width - 10, 35)
        headLabel.font = .systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)
        brandView.backgroundColor = .groupTableViewBackgroundColor()
        brandView.addSubview(headLabel)
        view.addSubview(brandView)
        refreshMode = .WillAppear
    }
    
    override func onLoadSuccess<E : ListModel>(entity: E) {
        super.onLoadSuccess(entity)
        headLabel.text = "共计\(getCount())家报价，报价有效期24小时"
    }
    
    override func getItemView<V : UITableView, T : Offer, C : OfferListCell>(listView: V, indexPath: NSIndexPath, item: T, cell: C) -> C {
        cell.setData(item)
        return cell
    }
    
    override func onPerform<T : Offer>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            startActivity(Item(dest: OfferDetail.self, storyboard: false))
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
    }
    
    override func onSegue(segue: UIStoryboardSegue?, dest: UIViewController, id: String) {
        dest.setValue(getSelected().first, forKey: "data")
    }
    
    // MARK: - 💜 UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return TAB_BAR_HEIGHT + 64
    }
}
