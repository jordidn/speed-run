//
//  SRBaseTableViewCell.swift
//  SpeedRun
//
//  Created by Jordi Durán on 30/01/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import UIKit

protocol SRBaseTableViewCellDelegate: class {
    func configure(cellVM: SRBaseTableViewCellViewModel)
    func configureAccesibility()
}

class SRBaseTableViewCell: UITableViewCell, SRBaseTableViewCellDelegate {

    // MARK: - var, constants, etc...
    
    fileprivate (set) var baseCellVM: SRBaseTableViewCellViewModel?
    
    
    // MARK: - Live cicle method's
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.configureAccesibility()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK: - Override for custom implementation
    
    open func configure(cellVM: SRBaseTableViewCellViewModel) { self.baseCellVM = cellVM }
    open func configureAccesibility() {}

}
