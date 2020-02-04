//
//  SRLeaderboardResponse.swift
//  SpeedRun
//
//  Created by Jordi Durán on 04/02/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import Foundation
import ObjectMapper

struct SRLeaderboardResponse: Codable {

    // MARK: Properties
    var data: SRLeaderboardData?

    // Custom Keys
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
}

struct SRLeaderboardData: Codable {

    // MARK: Properties
    var weblink: String?
    var game: String?
    var category: String?
    var level: String?
    var platform: String?
    var region: String?
    var emulators: String?
    var videoOnly: Bool?
    var timing: String?
//    var values: String?
    var runs: [SRRuns]?
    var links: [SRLinks]?

    // Custom Keys
    enum CodingKeys: String, CodingKey {
        case weblink = "weblink"
        case game = "game"
        case category = "category"
        case level = "level"
        case platform = "platform"
        case region = "region"
        case emulators = "emulators"
        case videoOnly = "video-only"
        case timing = "timing"
//        case values = "values"
        case runs = "runs"
        case links = "links"
    }
    
    func getFirstRun() -> SRRun? {
        guard let runs = self.runs else { return nil }
        for run in runs {
            if let place = run.place, place == 1 {
                return run.run
            }
        }
        return nil
    }
    
}

struct SRRuns: Codable {

    // MARK: Properties
    var place: Int?
    var run: SRRun?
    
    // Custom Keys
    enum CodingKeys: String, CodingKey {
        case place = "place"
        case run = "run"
    }
    
}

struct SRRun: Codable {

    // MARK: Properties
    var id: String?
    var weblink: String?
    var game: String?
//    var level: String?
    var category: String?
    var videos: SRVideos?
    var comment: String?
    var status: SRStatus?
    var players: [SRPlayers]?
    var date: String?
    var submitted: String?
    var times: SRTimes?
    var system: SRSystem?
    var splits: String?
//    var values: String?
    
    // Custom Keys
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case weblink = "weblink"
        case game = "game"
//        case level = "level"
        case category = "category"
        case videos = "videos"
        case comment = "comment"
        case status = "status"
        case players = "players"
        case date = "date"
        case submitted = "submitted"
        case times = "times"
        case system = "system"
        case splits = "splits"
//        case values = "values"
    }
    
    func getFirstPLayerURL() -> String? {
        return players?.first?.uri
    }
    
}
