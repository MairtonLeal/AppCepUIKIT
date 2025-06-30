//
//  CellModels.swift
//  CepTableView
//
//  Created by Mairton Leal on 28/12/23.
//


import Foundation
import UIKit

protocol AlertCellDelegate {
    func didTapOnAlertAction(actionID: String)
}

struct CellModels {
    
 
    struct Text: VModel {
        var text: String
//        var font: UIFont
        var color: UIColor?
        var alignment: NSTextAlignment = .left
        var constraintTop: CGFloat = 0.0
        var constraintBottom: CGFloat = 8.0
    }
    
    struct linkButton: VModel {
        var identifier: Int
        var labelLink: String
        var font: UIFont?
        var color: UIColor?
        var arrowImage: UIImage?
        var alignment: NSTextAlignment?
        var constraintTop: CGFloat?
        var constraintBottom: CGFloat?
    }

    
    struct MarkText: VModel {
        var text: String
        var font: UIFont
        var color: UIColor?
        var constraintTop: CGFloat = 4.0
        var constraintBottom: CGFloat = 4.0
    }
  
    
}
