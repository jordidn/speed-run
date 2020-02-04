//
//  SRGamesListViewModel.swift
//  SpeedRun
//
//  Created by Jordi Durán on 30/01/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import UIKit

class SRGamesListViewModel: NSObject {
    
    // MARK: - Properties
    
    fileprivate let manager = SRGamesListManager()
    
    
    // MARK: - Config Methods
    
    func resetData() {
        manager.resetData()
    }
    
    func getCellsVM(withError error: Bool = false) -> [SRBaseTableViewCellViewModel] {
        var cellsVM = [SRBaseTableViewCellViewModel]()
        
        guard !error else { return [SRErrorCellViewModel(titleText: "An error has occurred", buttonText: "Try again")] }
        guard let gamesList = manager.gamesList else { return [SRLoadingCellViewModel()] }
        for game in gamesList {
            guard let internationalName = game.getGameName(), let asset = game.assets?.coverTiny else { continue }
            cellsVM.append(SRGameListCellViewModel(titleText: internationalName, imagePathURL: URL(string: asset.uri ?? ""), imageWith: asset.width, imageHeight: asset.height, cellActionIdentifier: game))
        }
        
        cellsVM.append(SRErrorCellViewModel(titleText: "An error has occurred", buttonText: "Try again"))
        return cellsVM
    }

    
    // MARK: - Fetch Request
    
    func fetchGamesList(success succeed: @escaping (() -> Void), error: @escaping (() -> Void)) {
        manager.fetchGamesList(success: succeed, error: error)
    }
    
}
