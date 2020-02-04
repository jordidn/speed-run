//
//  SRLoadingTableViewCell.swift
//  SpeedRun
//
//  Created by Jordi Durán on 02/02/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import UIKit

class SRLoadingTableViewCell: SRBaseTableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Config Methods
    
    override func configure(cellVM: SRBaseTableViewCellViewModel) {
        super.configure(cellVM: cellVM)
        
        activityIndicator.startAnimating()
    }
    
}



class SRLoadingCellViewModel: SRBaseTableViewCellViewModel {
    
    init() {
        super.init(cellType: .loadingCell)
    }
    
}
