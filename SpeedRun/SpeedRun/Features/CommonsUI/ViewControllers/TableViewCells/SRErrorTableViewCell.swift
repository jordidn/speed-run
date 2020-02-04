//
//  SRErrorTableViewCell.swift
//  SpeedRun
//
//  Created by Jordi Durán on 02/02/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import UIKit

protocol SRErrorTableViewCellProtocol: class {
    func errorButtonPressed(cellActionIdentifier: Any?)
}

class SRErrorTableViewCell: SRBaseTableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var bottomButton: UIButton!
    
    
    // MARK: - Properties
    
    weak var delegate: SRErrorTableViewCellProtocol?
    
    
    // MARK: - IBActions
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        delegate?.errorButtonPressed(cellActionIdentifier: baseCellVM?.cellActionIdentifier)
    }
    
    
    // MARK: - Config Methods
    
    func configure(cellVM: SRBaseTableViewCellViewModel, delegate: SRErrorTableViewCellProtocol?) {
        super.configure(cellVM: cellVM)
        guard let cellVM = cellVM as? SRErrorCellViewModel else { return }
        
        self.lblTitle.text = cellVM.titleText
        self.bottomButton.setTitle(cellVM.buttonText, for: .normal)
        
        self.delegate = delegate
    }
    
}



class SRErrorCellViewModel: SRBaseTableViewCellViewModel {
    
    var buttonText: String?
    
    
    init(titleText: String?, buttonText: String?, cellActionIdentifier: Any? = nil) {
        super.init(cellType: .errorCell)
        self.titleText = titleText
        self.cellActionIdentifier = cellActionIdentifier
        
        self.buttonText = buttonText
    }
    
}
