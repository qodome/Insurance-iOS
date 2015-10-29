//
//  Copyright © 2015年 NY. All rights reserved.
//

protocol PickerListDelegate {
    func backPickerModel(model: PickerModel)
}

class PickerList: TableDetail {
    var pickerData: [PickerModel] = []
    var pickerDelegate: PickerListDelegate?
    var selectedId = ""
    var titleName = ""
    
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        title = titleName
        items = [[]]
        for pickerModel in pickerData {
            selectedId = pickerModel.pid == selectedId ? pickerModel.plabel : selectedId
            items[0] += [Item(title: pickerModel.plabel, segue: "none")]
        }
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        if selectedId == "" {
            cell.accessoryType = indexPath.row == 0 ? .Checkmark : .None
        }else {
            cell.accessoryType = cell.textLabel?.text == selectedId ? .Checkmark: .None
        }
        return cell
    }
    
    override func onPerform<T : Item>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            cancel()
            pickerDelegate!.backPickerModel(pickerData[indexPath.row])
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
    }
}
