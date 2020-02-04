//
//  SRBaseTableViewCellType.swift
//  SpeedRun
//
//  Created by Jordi Durán on 30/01/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import UIKit

enum SRBaseTableViewCellType: String {

    case gameListCell = "SRGameListTableViewCell"
    case loadingCell = "SRLoadingTableViewCell"
    case errorCell = "SRErrorTableViewCell"
    case buttonCell = "SRButtonTableViewCell"
    case titleDescriptionCell = "SRTitleSubtitleTableViewCell"
    case imageWithTitleCell = "SRImageWithTitleTableViewCell"
    
    
    func getNibName() -> String {
        return self.rawValue
    }
    
    func getHeightCell() -> CGFloat {
        switch self {
        case .gameListCell, .errorCell, .buttonCell, .titleDescriptionCell, .imageWithTitleCell:
            return UITableView.automaticDimension
        case .loadingCell:
            return 90
        }
    }
    
    func getHeightEstimatedCell() -> CGFloat {
        switch self {
        case .gameListCell, .buttonCell, .titleDescriptionCell, .imageWithTitleCell:
            return 80
        case .loadingCell:
            return 90
        case .errorCell:
            return 100
        }
    }
    
}
