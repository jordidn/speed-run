//
//  SRBaseTableViewCellViewModel.swift
//  SpeedRun
//
//  Created by Jordi Durán on 30/01/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import UIKit

class SRBaseTableViewCellViewModel: NSObject {

    private (set) var cellType: SRBaseTableViewCellType
    
    var titleText: String?
    var showSeparator: Bool = true
    
    var cellHeight: CGFloat?
    // This var defines the action to be performed
    var cellActionIdentifier: Any?
    
    init(cellType: SRBaseTableViewCellType) {
        self.cellType = cellType
    }
    
}

extension SRBaseTableViewCellViewModel {
    
    /// Configure the table view
    static func configureTable(_ tableView: UITableView, bounces: Bool = false) {
        tableView.bounces = bounces
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    /// Configure the table view for TJBaseTableViewCellType
    static func registerTableViewCells(_ tableView: UITableView, cellsVM: [SRBaseTableViewCellViewModel]) {
        let nibNames: Set<SRBaseTableViewCellType> = Set(cellsVM.map({ $0.cellType }))
        for nibName in nibNames {
            tableView.srRegisterCell(nibName: nibName)
        }
    }
    
    /// Get height of a index cell
    static func getCellHeight(cellsVM: [SRBaseTableViewCellViewModel], index: Int) -> CGFloat {
        guard let cellVM = getCellVM(atIndex: index, forCellsVM: cellsVM) else { return UITableView.automaticDimension }
        if let cellHeight = cellVM.cellHeight { return cellHeight }
        return cellVM.cellType.getHeightCell()
    }
    
    /// Get estimated height of a index cell
    static func getCellEstimatedHeight(cellsVM: [SRBaseTableViewCellViewModel], index: Int) -> CGFloat {
        guard let cellVM = getCellVM(atIndex: index, forCellsVM: cellsVM) else { return UITableView.automaticDimension }
        if let cellHeight = cellVM.cellHeight { return cellHeight }
        return cellVM.cellType.getHeightEstimatedCell()
    }
    
    /// Get table view cell for row
    static func tableViewCell(forRowAtIndexPath indexPath: IndexPath, _ tableView: UITableView, cellsVM: [SRBaseTableViewCellViewModel], delegate: Any) -> UITableViewCell {
        let index = indexPath.row
        guard let cellVM = getCellVM(atIndex: index, forCellsVM: cellsVM) else { return UITableViewCell() }
        switch cellVM.cellType {
        case .gameListCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.cellType.getNibName(), for: indexPath) as? SRGameListTableViewCell {
                cell.configure(cellVM: cellVM)
                return cell
            }
        case .loadingCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.cellType.getNibName(), for: indexPath) as? SRLoadingTableViewCell {
                cell.configure(cellVM: cellVM)
                return cell
            }
        case .errorCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.cellType.getNibName(), for: indexPath) as? SRErrorTableViewCell {
                cell.configure(cellVM: cellVM, delegate: delegate as? SRErrorTableViewCellProtocol)
                return cell
            }
        case .buttonCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.cellType.getNibName(), for: indexPath) as? SRButtonTableViewCell {
                cell.configure(cellVM: cellVM, delegate: delegate as? SRButtonTableViewCellProtocol)
                return cell
            }
        case .titleDescriptionCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.cellType.getNibName(), for: indexPath) as? SRTitleSubtitleTableViewCell {
                cell.configure(cellVM: cellVM)
                return cell
            }
        case .imageWithTitleCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.cellType.getNibName(), for: indexPath) as? SRImageWithTitleTableViewCell {
                cell.configure(cellVM: cellVM)
                return cell
            }
        }

        return UITableViewCell()
    }
    
    /// Get cellVM at index if index is valid.
    static func getCellVM(atIndex index: Int, forCellsVM cellsVM: [SRBaseTableViewCellViewModel]) -> SRBaseTableViewCellViewModel? {
        guard index >= 0 && index < cellsVM.count else { return nil }
        return cellsVM[index]
    }
    
}
