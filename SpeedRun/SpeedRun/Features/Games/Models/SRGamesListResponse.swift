//
//  SRGamesListResponse.swift
//  SpeedRun
//
//  Created by Jordi Durán on 30/01/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import Foundation
import ObjectMapper

struct SRGamesListResponse: Decodable {
    
    // MARK: Properties
    var data: [SRGameModel]?
    var pagination: SRPagination?
    
}

struct SRPagination: Decodable {
    
    // MARK: Properties
    var offset: Int?
    var max: Int?
    var size: Int?
    var links: [SRLinks]?
    
}

struct SRGameModel: Decodable {
    
    // MARK: Properties
    var id: String?
    var names: SRNames?
    var abbreviation: String?
    var weblink: String?
    var released: Int?
    var releaseDate: String?
    var ruleset: SRRuleset?
    var romhack: Bool?
    var gametypes: [String]?
    var platforms: [String]?
    var regions: [String]?
    var genres: [String]?
    var engines: [String]?
    var developers: [String]?
    var publishers: [String]?
    var created: String?
    var assets: SRAssets?
    var links: [SRLinks]?
    
    
    func getGameName() -> String? {
        return names?.international
    }
    
    func getURL(_ urlType: SRGameURLType) -> String? {
        guard let links = links else { return nil }
        for link in links {
            if let name = link.rel, name == urlType.rawValue {
                return link.uri
            }
        }
        return nil
    }
    
}

enum SRGameURLType: String {
    case runs = "runs"
    case levels = "levels"
    case categories = "categories"
    case variables = "variables"
    case records = "records"
    case series = "series"
    case derivedGames = "derived-games"
    case romhacks = "romhacks"
    case leaderboard = "leaderboard"
}


struct SRLinks: Codable {
    
    // MARK: Properties
    var rel: String?
    var uri: String?
    
    // Custom Keys
    enum CodingKeys: String, CodingKey {
        case rel = "rel"
        case uri = "uri"
    }
    
}

struct SRAssets: Codable {
    
    // MARK: Properties
    var logo: SRAssetsModels?
    var coverTiny: SRAssetsModels?
    var coverSmall: SRAssetsModels?
    var coverMedium: SRAssetsModels?
    var coverLarge: SRAssetsModels?
    var icon: SRAssetsModels?
    var trophy1st: SRAssetsModels?
    var trophy2nd: SRAssetsModels?
    var trophy3rd: SRAssetsModels?
    var trophy4th: SRAssetsModels?
    var background: SRAssetsModels?
    var foreground: SRAssetsModels?
    
    // Custom Keys
    enum CodingKeys: String, CodingKey {
        case logo
        case coverTiny = "cover-tiny"
        case coverSmall = "cover-small"
        case coverMedium = "cover-medium"
        case coverLarge = "cover-large"
        case icon
        case trophy1st
        case trophy2nd
        case trophy3rd
        case trophy4th
        case background
        case foreground
    }
    
}

struct SRAssetsModels: Codable {
    
    // MARK: Properties
    var uri: String?
    var width: CGFloat?
    var height: CGFloat?
    
    // Custom Keys
    enum CodingKeys: String, CodingKey {
        case uri
        case width
        case height
    }
    
}

struct SRRuleset: Decodable {
    
    // MARK: Properties
    var showMilliseconds: Bool?
    var requireVerification: Bool?
    var requireVideo: Bool?
    var runTimes: [String]?
    var defaultTime: String?
    var emulatorsAllowed: Bool?
    
}

struct SRNames: Codable {
    
    // MARK: Properties
    var international: String?
    var japanese: String?
    var twitch: String?
    
    // Custom Keys
    enum CodingKeys: String, CodingKey {
        case international = "international"
        case japanese = "japanese"
        case twitch = "twitch"
    }
    
}
