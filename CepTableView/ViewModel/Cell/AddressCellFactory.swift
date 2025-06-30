//
//  AddressCellFactory.swift
//  CepTableView
//
//  Created by Mairton Leal on 28/12/23.
//

import UIKit

struct AddressCellFactory: CellFactory {
    static func get(model: VModel, tableView: UITableView, indexPath: IndexPath, delegate: BaseViewDataSourceDelegate?) -> UITableViewCell {
        if let model = model as? CellModels.Text {
            let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier) as! TextTableViewCell
            cell.bind(model: model)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    static func create(tableView: UITableView) {
        tableView.register(TextTableViewCell.nib, forCellReuseIdentifier: TextTableViewCell.identifier)
    }
    
}
