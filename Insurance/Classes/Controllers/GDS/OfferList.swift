//
//  Copyright © 2015年 NY. All rights reserved.
//

class OfferList: TableList {
    let headLabel = UILabel()
    
    // MARK: - 🐤 Taylor
    override func onPrepare<T : UITableView>(listView: T) {
        super.onPrepare(listView)
        listView.registerClass(OfferCell.self, forCellReuseIdentifier: cellId)
        let brandView = UIView(frame: CGRectMake(0, 0 , SCREEN_WIDTH, 35))
        (listView as UITableView).tableHeaderView = brandView
        headLabel.frame = CGRectMake(10, 0 , SCREEN_WIDTH - 10, 35)
        headLabel.font = UIFont.systemFontOfSize(14)
        brandView.backgroundColor = UIColor.colorWithHex(BACKGROUND_COLOR)
        brandView.addSubview(headLabel)
        view.addSubview(brandView)
        refreshMode = .DidLoad
    }
    
    override func onCreateLoader() -> BaseLoader? {
        let firstMapping = smartMapping(ListModel.self)
        let mapping = smartMapping(Offer.self, children: ["brand" : Brand.self, "agent" : Branch.self])
        let groupMapping = smartMapping(ListModel.self)
        let groupNext = smartMapping(InsuranceGroup.self)
        groupNext.addRelationshipMappingWithSourceKeyPath("insurances", mapping: smartListMapping(Insurance.self))
        groupMapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "results", toKeyPath: "results", withMapping: groupNext))
        mapping.addRelationshipMappingWithSourceKeyPath("insurance_groups", mapping: groupMapping)
        firstMapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "results", toKeyPath: "results", withMapping: mapping))
        return HttpLoader(endpoint: endpoint, mapping: firstMapping)
    }
    
    override func onLoadSuccess<E : ListModel>(entity: E) {
        super.onLoadSuccess(entity)
        headLabel.text = "共计\(listData.count)家报价，请在当日完成交易"
    }
    
    override func getItemView<V : UITableView, T : Offer, C : OfferCell>(listView: V, indexPath: NSIndexPath, item: T, cell: C) -> C {
        cell.setData(item)
        cell.accessoryType = .DisclosureIndicator
        cell.selectionStyle = .None
        return cell
    }
    
    override func onPerform<T : Offer>(action: Action, item: T) {
        switch action {
        case .Open:
            let offerDetail = OfferDetail()
            offerDetail.data = item
            offerDetail.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(offerDetail, animated: true)
        default:
            super.onPerform(action, item: item)
        }
    }
    
    // MARK: - 💜 UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
}
