//
//  SRRunDetailResponse.swift
//  SpeedRun
//
//  Created by Jordi Durán on 03/02/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import Foundation
import ObjectMapper

struct SRRunDetailResponse: Decodable {

    // MARK: Properties
    var data: [SRRunDetailData]?
    var pagination: SRPagination?
    
}

struct SRRunDetailData: Decodable {

    // MARK: Properties
    var id: String?
    var weblink: String?
    var game: String?
    var level: String?
    var category: String?
    var videos: SRVideos?
    var comment: String?
//    var status: SRStatus?
//    var players: [SRPlayers]?
    var date: String?
    var submitted: String?
//    var times: SRTimes?
//    var system: SRSystem?
    var splits: String?
//    var values: String?
//    var links: [SRLinks]?
    
}

struct SRSystem: Codable {

    // MARK: Properties
    var platform: String?
//    var emulated: Bool?
//    var region: String?
    
    // Custom Keys
    enum CodingKeys: String, CodingKey {
        case platform
//        case emulated = "emulated"
//        case region
    }
    
}

struct SRTimes: Codable {

    // MARK: Properties
    var primary: String?
    var primaryT: Int?
    var realtime: String?
    var realtimeT: Int?
//    var realtimeNoloads: String?
    var realtimeNoloadsT: Int?
//    var ingame: String?
    var ingameT: Int?

    // Custom Keys
    enum CodingKeys: String, CodingKey {
        case primary
        case primaryT = "primary_t"
        case realtime
        case realtimeT = "realtime_t"
//        case realtimeNoloads = "realtime_noloads"
        case realtimeNoloadsT = "realtime_noloads_t"
//        case ingame
        case ingameT = "cover-small"
    }
    
}

struct SRPlayers: Codable {

    // MARK: Properties
    var rel: String?
    var id: String?
    var uri: String?
    
    // Custom Keys
    enum CodingKeys: String, CodingKey {
        case rel = "rel"
        case id = "id"
        case uri = "uri"
    }
    
}

struct SRStatus: Codable {

    // MARK: Properties
    var status: String?
    var examiner: String?
    var verifyDate: String?

    // Custom Keys
    enum CodingKeys: String, CodingKey {
        case status
        case examiner
        case verifyDate = "verify-date"
    }
    
}

struct SRVideos: Codable {

    // MARK: Properties
    var links: [SRLinks]?

    // Custom Keys
    enum CodingKeys: String, CodingKey {
        case links = "links"
    }
    
}


struct SRVideoLinks: Codable {
    
    // MARK: Properties
    var uri: String?
    
    // Custom Keys
    enum CodingKeys: String, CodingKey {
        case uri = "uri"
    }
    
}
