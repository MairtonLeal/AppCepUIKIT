//
//  UniqueViewDataSource.swift
//  CepTableView
//
//  Created by Mairton Leal on 28/12/23.


import Foundation
import UIKit

public protocol UniqueViewDataSourceDelegate: BaseViewDataSourceDelegate {
}

public extension UniqueViewDataSourceDelegate {
    func getController() -> UIViewController { return UITableViewController() }
    func getTableViewCell() -> UITableViewCell { return UITableViewCell() }
    func getView() -> UIView { return UIView() }
}

public class UniqueViewDataSource<Cells: CellFactory>: NSObject, UITableViewDataSource, UITableViewDelegate {

    public var delegate: UniqueViewDataSourceDelegate?
    private var models: [VModel]
    public var getSizeHeader: (Int) -> CGFloat = { index in
        return 0.0
    }
    public var getSizeFooter: (Int) -> CGFloat = { index in
        return 0.0
    }

    public static func make(tableView: UITableView) -> UniqueViewDataSource {
        Cells.create(tableView: tableView)
        return UniqueViewDataSource(models: [])
    }

    public static func make(tableView: UITableView, models: [VModel]) -> UniqueViewDataSource {
        Cells.create(tableView: tableView)
        return UniqueViewDataSource(models: models)
    }

    public init(models: [VModel]) {
        self.models = models
    }

    public func update(models: [VModel]) {
        self.models = models
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return Cells.get(model: models[indexPath.row], tableView: tableView, indexPath: indexPath, delegate: delegate)
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectedItem(model: models[indexPath.row], indexPath: indexPath)
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return getSizeHeader(section)
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}
