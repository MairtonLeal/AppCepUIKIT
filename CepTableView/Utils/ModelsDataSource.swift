//
//  ModelsDataSource.swift
//  CepTableView
//
//  Created by Mairton Leal on 28/12/23.
//

import Foundation
import UIKit

public protocol VModel {}
public protocol VSection {
    var rows: [VModel] { get set }
}


public protocol CellFactory {
    static func get(model: VModel, tableView: UITableView, indexPath: IndexPath, delegate: BaseViewDataSourceDelegate?) -> UITableViewCell
    static func create(tableView: UITableView)
}

public protocol BaseCellProtocol {
    associatedtype ModelCell
    static var identifier: String { get }
    static var nib: UINib { get }
    func bind(model: ModelCell)
}

public protocol BaseSectionHeader {
    associatedtype ModelHeader
    static var identifier: String { get }
    static var nib: UINib { get }
    func bind(model: ModelHeader)
}

public protocol BaseViewDataSourceDelegate {
    func didSelectedItem(model: VModel, indexPath: IndexPath)
    func getController() -> UIViewController
}


