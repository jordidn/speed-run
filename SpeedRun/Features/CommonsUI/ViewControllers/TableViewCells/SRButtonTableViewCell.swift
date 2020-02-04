//
//  SRButtonTableViewCell.swift
//  SpeedRun
//
//  Created by Jordi Durán on 03/02/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import UIKit

protocol SRButtonTableViewCellProtocol: class {
    func simpleButtonPressed(cellActionIdentifier: Any?)
}

class SRButtonTableViewCell: SRBaseTableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var btnSimple: UIButton!
    
    // MARK: - Properties
    
    weak var delegate: SRButtonTableViewCellProtocol?
    
    
    // MARK: - IBActions
    
    @IBAction func simpleButtonPressed(_ sender: UIButton) {
        delegate?.simpleButtonPressed(cellActionIdentifier: baseCellVM?.cellActionIdentifier)
    }
    
    
    // MARK: - Config Methods
    
    func configure(cellVM: SRBaseTableViewCellViewModel, delegate: SRButtonTableViewCellProtocol?) {
        super.configure(cellVM: cellVM)
        guard let cellVM = cellVM as? SRButtonCellViewModel else { return }
        
        self.btnSimple.setTitle(cellVM.buttonText, for: .normal)
        
        self.delegate = delegate
    }
    
}



class SRButtonCellViewModel: SRBaseTableViewCellViewModel {
    
    var buttonText: String?
    
    
    init(buttonText: String?, cellActionIdentifier: Any? = nil) {
        super.init(cellType: .buttonCell)
        self.cellActionIdentifier = cellActionIdentifier
        
        self.buttonText = buttonText
    }
    
}
