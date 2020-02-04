//
//  SRImageWithTitleTableViewCell.swift
//  SpeedRun
//
//  Created by Jordi Durán on 04/02/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import UIKit

class SRImageWithTitleTableViewCell: SRBaseTableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var iconWithConstraint: NSLayoutConstraint!
    @IBOutlet weak var iconHeightConstraint: NSLayoutConstraint!
    
    
    // MARK: - Config Methods
       
    override func configure(cellVM: SRBaseTableViewCellViewModel) {
        super.configure(cellVM: cellVM)
        guard let cellVM = cellVM as? SRImageWithTitleCellViewModel else { return }
       
        self.lblTitle.text = cellVM.titleText
        self.iconImageView.image = UIImage(named: "empty_state_icon", in: SPEEDRUN.bundle, compatibleWith: nil)
        if let imagePathURL = cellVM.imagePathURL {
            self.iconImageView.load(url: imagePathURL)
        }
        
        self.iconWithConstraint.constant = cellVM.imageWith ?? 50
        self.iconHeightConstraint.constant = cellVM.imageHeight ?? 50
    }
    
}



class SRImageWithTitleCellViewModel: SRBaseTableViewCellViewModel {
    
    var imagePathURL: URL?
    var imageWith: CGFloat?
    var imageHeight: CGFloat?
    
    
    init(titleText: String?, imagePathURL: URL?, imageWith: CGFloat?, imageHeight: CGFloat?, cellActionIdentifier: Any? = nil) {
        super.init(cellType: .imageWithTitleCell)
        self.titleText = titleText
        self.cellActionIdentifier = cellActionIdentifier
        
        self.imagePathURL = imagePathURL
        self.imageWith = imageWith
        self.imageHeight = imageHeight
    }
    
}
