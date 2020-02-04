//
//  SPEEDRUN.swift
//  SpeedRun
//
//  Created by Jordi Durán on 30/01/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import UIKit

class SPEEDRUN: NSObject {

    internal static let REQUEST_IDENTIFIER = String(describing: SPEEDRUN.self)
    static let bundle = Bundle(for: SPEEDRUN.self)
    
    static func loadImage(named imageName: String) -> UIImage? {
        return UIImage(named: imageName, in: SPEEDRUN.bundle, compatibleWith: nil)
    }
    
}
