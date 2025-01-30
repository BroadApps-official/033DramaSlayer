//
//  MainModel.swift
//  033DramaSlayer
//
//  Created by Владимир on 16.01.2025.
//

import Foundation
import UIKit

class MainModel {
    
    let purchaseManager = PurchaseManager()
    lazy var profileSettings: ProfileButton = DataFlow.loadButtonSettingsFromFile() ?? ProfileButton(bgColor: 1, iconColor: 1, name: "Name")
    
    func returnBGButtonColor() -> UIColor {
        switch profileSettings.bgColor {
        case 1:
            return #colorLiteral(red: 1, green: 0.9057424664, blue: 0.8297246695, alpha: 1)
        case 2:
            return #colorLiteral(red: 1, green: 0.7400861382, blue: 0.7469835877, alpha: 1)
        case 3:
            return #colorLiteral(red: 0.9272580743, green: 1, blue: 0.8225690126, alpha: 1)
        case 4:
            return #colorLiteral(red: 0.8062443137, green: 0.9735847116, blue: 1, alpha: 1)
        case 5:
            return #colorLiteral(red: 0.9294145107, green: 0.8358896971, blue: 1, alpha: 1)
        case 6:
            return #colorLiteral(red: 1, green: 0.7692925334, blue: 1, alpha: 1)
        case 7:
            return #colorLiteral(red: 1, green: 0.9590832591, blue: 0.7495272756, alpha: 1)
        default:
            return .white
        }
    }
    
    func returnBGButtonColorIcon() -> UIColor {
        switch profileSettings.iconColor {
        case 1:
            return #colorLiteral(red: 1, green: 0.3380622268, blue: 0, alpha: 1)
        case 2:
            return #colorLiteral(red: 1, green: 0, blue: 0.09563680738, alpha: 1)
        case 3:
            return #colorLiteral(red: 0, green: 0.9265136719, blue: 0, alpha: 1)
        case 4:
            return #colorLiteral(red: 0, green: 0.6231221557, blue: 1, alpha: 1)
        case 5:
            return #colorLiteral(red: 0.6374842525, green: 0.1940310299, blue: 1, alpha: 1)
        case 6:
            return #colorLiteral(red: 1, green: 0, blue: 0.5615196824, alpha: 1)
        case 7:
            return #colorLiteral(red: 1, green: 0.8521838188, blue: 0, alpha: 1)
        default:
            return .white
        }
    }
}
