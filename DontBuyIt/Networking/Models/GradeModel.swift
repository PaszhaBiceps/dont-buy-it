//
//  GradeModel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 02.06.2022.
//

import Foundation
import SwiftUI

struct GradeModel: APIModel,
                   Codable,
                   Comparable {
    
    let originalName: String?
    let translatedName: String?
    let description: String?
    let colorHexString: String?
    let priority: Int?
    let availableForPurchase: Bool
    
    var id: Int {
        (originalName ?? "").lowercased().hashValue
    }
    var color: Color? {
        guard let hex = colorHexString,
              !hex.isEmpty else { return nil }
        return Color(hex)
    }
    var name: String? {
        if Locale.current.languageCode == "uk" {
            return translatedName
        } else {
            return originalName
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case originalName = "name"
        case translatedName = "displayName"
        case description
        case colorHexString = "color"
        case priority
        case availableForPurchase
    }
    
    // MARK: - Convenience
    static func stub() -> Self {
        return GradeModel(originalName: "Grade",
                          translatedName: "Оцінка",
                          description: "Stub description",
                          colorHexString: "#D8319C",
                          priority: 99,
                          availableForPurchase: true)
        
    }
    
    static func unknown() -> Self {
        return GradeModel(originalName: "Unknown",
                          translatedName: "Невідомо",
                          description: "Ще немає інформації стосовно цього бренду",
                          colorHexString: "#586261",
                          priority: 99,
                          availableForPurchase: false)
    }
    
    // MARK: - Comparable
    static func < (lhs: GradeModel, rhs: GradeModel) -> Bool {
        (lhs.priority ?? 0) < (rhs.priority ?? 0)
    }
}
