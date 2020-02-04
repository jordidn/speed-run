//
//  SRGameDetailManager.swift
//  SpeedRun
//
//  Created by Jordi Durán on 02/02/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import UIKit

class SRGameDetailManager: NSObject {

    // MARK: - Properties
    
    fileprivate (set) var gameModel: SRGameModel?
    fileprivate (set) var leaderboardModel: SRLeaderboardData?
    fileprivate (set) var playerModel: SRPlayerData?
    
    
    // MARK: - Config Methods
    
    func resetData() {
        self.leaderboardModel = nil
    }
    
    func setGameModel(gameModel: SRGameModel?) {
        self.gameModel = gameModel
    }
    
    
    
    // MARK: - Fetch Request
       
    func fetchGameDetail(success succeed: @escaping (() -> Void), error: @escaping (() -> Void)) {
        guard let stringURL = gameModel?.getURL(.leaderboard), let url = URL(string: stringURL) else {
            error()
            return
        }
       
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, err) in
            guard let data = data else {
                error()
                return
            }
           
            do {
                let responseModel = try JSONDecoder().decode(SRLeaderboardResponse.self, from: data)
                guard let leaderboardModel = responseModel.data else {
                    error()
                    return
                }
                self?.leaderboardModel = leaderboardModel
                self?.fetchPlayerData(success: succeed, error: {})
                succeed()
               
            } catch let jsonError {
                print(jsonError)
                error()
            }
        }.resume()
    }
    
    func fetchPlayerData(success succeed: @escaping (() -> Void), error: @escaping (() -> Void)) {
        guard let stringURL = leaderboardModel?.getFirstRun()?.getFirstPLayerURL(), let url = URL(string: stringURL) else {
            error()
            return
        }
       
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, err) in
            guard let data = data else {
                error()
                return
            }
           
            do {
                let responseModel = try JSONDecoder().decode(SRPlayerResponse.self, from: data)
                guard let playerModel = responseModel.data else {
                    error()
                    return
                }
                self?.playerModel = playerModel
                succeed()
               
            } catch let jsonError {
                print(jsonError)
                error()
            }
        }.resume()
    }
    
}
