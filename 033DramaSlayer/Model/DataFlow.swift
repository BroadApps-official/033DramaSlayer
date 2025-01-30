//
//  DataFlow.swift
//  033DramaSlayer
//
//  Created by Владимир on 17.01.2025.
//

import Foundation

class DataFlow {
    
    static func loadButtonSettingsFromFile() -> ProfileButton? {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Unable to get document directory")
            return nil
        }
        let filePath = documentDirectory.appendingPathComponent("ProfileButton.plist")
        do {
            let data = try Data(contentsOf: filePath)
            let arr = try JSONDecoder().decode(ProfileButton.self, from: data)
            return arr
        } catch {
            print("Failed to load or decode athleteArr: \(error)")
            return nil
        }
    }
    
    static func saveButtonSettingsToFile(data: Data) throws {
        let fileManager = FileManager.default
        if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath = documentDirectory.appendingPathComponent("ProfileButton.plist")
            try data.write(to: filePath)
        } else {
            throw NSError(domain: "SaveError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to get document directory"])
        }
    }
    
//    func saveArr(arr: [UserHistory]) {
//        do {
//            let data = try JSONEncoder().encode(arr) //тут мкассив конвертируем в дату
//            try saveArrToFile(data: data)
//        } catch {
//            print("Failed to encode or save athleteArr: \(error)")
//        }
//    }
}
