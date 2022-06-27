//
//  GradeModel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 02.06.2022.
//

import Foundation
import SwiftUI

struct GradeModel: APIModel,
                   Codable {
    let name: String?
    let displayName: String?
    let description: String?
    let colorHexString: String?
    let priority: Int?
    let availableForPurchase: Bool
    
    var id: Int {
        (name ?? "").lowercased().hashValue
    }
    var color: Color? {
        guard let hex = colorHexString,
              !hex.isEmpty else { return nil }
        return Color(hex)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case displayName
        case description
        case colorHexString = "color"
        case priority
        case availableForPurchase
    }
    
    // MARK: - Convenience
    static func stub() -> Self {
        return GradeModel(name: "Grade",
                          displayName: "Оцінка",
                          description: "Stub description",
                          colorHexString: "#D8319C",
                          priority: 0,
                          availableForPurchase: true)
    }
}
