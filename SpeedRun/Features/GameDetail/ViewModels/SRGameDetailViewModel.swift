//
//  SRGameDetailViewModel.swift
//  SpeedRun
//
//  Created by Jordi Durán on 02/02/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import UIKit

class SRGameDetailViewModel: NSObject {

    // MARK: - Properties
    
    fileprivate let manager = SRGameDetailManager()
    
    
    // MARK: - Config Methods
    
    func resetData() {
        manager.resetData()
    }
    
    func setGameModel(gameModel: SRGameModel?) {
        manager.setGameModel(gameModel: gameModel)
    }
    
    func getGameTitle() -> String? {
        return manager.gameModel?.getGameName()
    }
    
    func getCellsVM(withError error: Bool = false) -> [SRBaseTableViewCellViewModel] {
        var cellsVM = [SRBaseTableViewCellViewModel]()
        
        guard !error else { return [SRErrorCellViewModel(titleText: "An error has occurred", buttonText: "Try again")] }
        guard let leaderboardModel = manager.leaderboardModel else { return [SRLoadingCellViewModel()] }
        guard let firstRun = leaderboardModel.getFirstRun() else { return [] }
        
        // Image and title Cell
        if let gameName = getGameTitle(), let asset = manager.gameModel?.assets?.coverMedium {
            cellsVM.append(SRImageWithTitleCellViewModel(titleText: gameName, imagePathURL:  URL(string: asset.uri ?? ""), imageWith: asset.width, imageHeight: asset.height))
        }

        // Player Name Cell
        if let playerName = manager.playerModel?.names?.international {
            cellsVM.append(SRTitleSubtitleCellViewModel(titleText: "Player’s name", descriptionText: playerName))
        }
        
        if let time = firstRun.times?.realtimeT {
            cellsVM.append(SRTitleSubtitleCellViewModel(titleText: "Time", descriptionText: SRUtils.formatTime(seconds: time)))
        }
        
        // Video URL Cell
        if let videoStringURL = firstRun.videos?.links?.first?.uri, let videoURL = URL(string: videoStringURL) {
            cellsVM.append(SRButtonCellViewModel(buttonText: "See the video", cellActionIdentifier: videoURL))
        }
        
        return cellsVM
    }
    
    
    // MARK: - Fetch Request
    
    func fetchGameDetail(success succeed: @escaping (() -> Void), error: @escaping (() -> Void)) {
        manager.fetchGameDetail(success: succeed, error: error)
    }
    
}
