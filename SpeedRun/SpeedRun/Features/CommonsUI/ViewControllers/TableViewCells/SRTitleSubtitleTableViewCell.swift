//
//  SRTitleSubtitleTableViewCell.swift
//  SpeedRun
//
//  Created by Jordi Durán on 03/02/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import UIKit

class SRTitleSubtitleTableViewCell: SRBaseTableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    
    // MARK: - Config Methods
       
    override func configure(cellVM: SRBaseTableViewCellViewModel) {
        super.configure(cellVM: cellVM)
        guard let cellVM = cellVM as? SRTitleSubtitleCellViewModel else { return }
       
        self.lblTitle.text = cellVM.titleText
        self.lblDescription.text = cellVM.descriptionText
    }
    
}



class SRTitleSubtitleCellViewModel: SRBaseTableViewCellViewModel {
    
    var descriptionText: String?
    
    
    init(titleText: String?, descriptionText: String?, cellActionIdentifier: Any? = nil) {
        super.init(cellType: .titleDescriptionCell)
        self.titleText = titleText
        self.cellActionIdentifier = cellActionIdentifier
        
        self.descriptionText = descriptionText
    }
    
}
