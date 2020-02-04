//
//  SRPlayerResponse.swift
//  SpeedRun
//
//  Created by Jordi Durán on 04/02/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import Foundation
import ObjectMapper

struct SRPlayerResponse: Codable {

    // MARK: Properties
    var data: SRPlayerData?

    // Custom Keys
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
}

struct SRPlayerData: Codable {

    // MARK: Properties
    var id: String?
    var names: SRNames?
    

    // Custom Keys
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case names = "names"
    }
    
}
