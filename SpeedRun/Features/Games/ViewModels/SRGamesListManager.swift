//
//  SRGamesListManager.swift
//  SpeedRun
//
//  Created by Jordi Durán on 30/01/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import UIKit
import SwiftAPI

class SRGamesListManager: NSObject {
    
    // MARK: - Properties
    
    fileprivate (set) var gamesList: [SRGameModel]?

    
    // MARK: - Config Methods
    
    func resetData() {
        self.gamesList = nil
    }

    
    
    // MARK: - Fetch Request
    
    func fetchGamesList(success succeed: @escaping (() -> Void), error: @escaping (() -> Void)) {
        
        let stringURL = "https://www.speedrun.com/api/v1/games"
        guard let url = URL(string: stringURL) else {
            error()
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, err) in
            guard let data = data else {
                error()
                return
            }
            
            do {
                let responseModel = try JSONDecoder().decode(SRGamesListResponse.self, from: data)
                self?.gamesList = responseModel.data
                succeed()
                
            } catch let jsonError {
                print(jsonError)
                error()
            }
        }.resume()
    }
    
}
