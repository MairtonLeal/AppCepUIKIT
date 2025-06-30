//
//  TextTableViewCell.swift
//  CepTableView
//
//  Created by Mairton Leal on 28/12/23.
//

import UIKit

class TextTableViewCell: UITableViewCell, BaseCellProtocol {
    typealias ModelCell = CellModels.Text
    
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var constraintTop: NSLayoutConstraint!
    @IBOutlet weak var constraintBottom: NSLayoutConstraint!
    
    static var identifier: String = "TextTableViewCell"
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func bind(model: CellModels.Text) {
        labelText.text = model.text
        labelText.textColor = model.color
        labelText.textAlignment = model.alignment
        constraintTop.constant = model.constraintTop
        constraintBottom.constant = model.constraintBottom
    }
    
}
