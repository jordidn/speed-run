//
//  SRUtils.swift
//  SpeedRun
//
//  Created by Jordi Durán on 30/01/2020.
//  Copyright © 2020 Jordi Durán. All rights reserved.
//

import UIKit

class SRUtils: NSObject {
    
    static func formatTime(seconds: Int) -> String {
        let (hours, minutes, seconds) = secondsToHoursMinutesSeconds(seconds: seconds)
        return "\(hours)h \(minutes)m \(seconds)s"
    }
    
    static func secondsToHoursMinutesSeconds(seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
}

internal extension UITableView {
    func srRegisterCell(nibName: SRBaseTableViewCellType) {
        let nibIdentifier = nibName.getNibName()
        self.register(UINib(nibName: nibIdentifier, bundle: SPEEDRUN.bundle), forCellReuseIdentifier: nibIdentifier)
    }
}

internal extension UIViewController {
    static func srStoryboardInstance(storyboardIdentifier: String) -> UIViewController {
        return UIStoryboard(name: storyboardIdentifier, bundle: SPEEDRUN.bundle).instantiateViewController(withIdentifier: String(describing: self))
    }
}

internal extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

internal extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

protocol DictionaryConvertible: class {
    func dictionaryRepresentation() -> [String: Any]
}

enum SRColor {
    case green
    case blue
    case gray
    case white
    case backgroundLightBlue
    case secondaryText
    
    func color() -> UIColor {
        switch self {
        case .green:
            return UIColor(hexString: "00C825")
        case .blue:
            return UIColor(hexString: "007DAE")
        case .gray:
            return UIColor(hexString: "89949E")
        case .white:
            return UIColor(hexString: "FFFFFF")
        case .backgroundLightBlue:
            return UIColor(hexString: "EFF8FB")
        case .secondaryText:
            return UIColor(hexString: "666666")
        }
    }
}
