//
//  Copyright © 2015年 NY. All rights reserved.
//

protocol PickerListDelegate {
    func onBackSegue(model: PickerModel)
}

class PickerList: GroupedTableDetail {
    var pickerData: [PickerModel] = []
    var delegate: PickerListDelegate?
    var selectedId = ""
    
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        for pickerModel in pickerData {
            selectedId = pickerModel.pid == selectedId ? pickerModel.plabel : selectedId
            items[0] += [Item(title: pickerModel.plabel, selectable: true)]
        }
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        cell.accessoryType = cell.textLabel?.text == selectedId ? .Checkmark : .None
        return cell
    }
    
    override func onPerform<T : Item>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            cancel()
            delegate?.onBackSegue(pickerData[indexPath.row])
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
    }
}
