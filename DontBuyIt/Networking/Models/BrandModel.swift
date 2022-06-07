//
//  BrandModel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 02.06.2022.
//

import Foundation

struct BrandModel: Codable {
    private let translatedCountry: String?
    private let translatedAction: String?
    private let translatedGicsIndustrySector: String?
    private let translatedMagnitudeOfOccupantOperations: String?
    private let originalCountry: String?
    private let originalAction: String?
    private let originalGicsIndustrySector: String?
    private let originalMagnitudeOfOccupantOperations: String?
    
    let name: String?
    let logoURL: String?
    let grade: String?
    let linkToAnnouncement: String?
    let products: [ProductModel]
    
    var id: Int {
        return (name ?? "").hashValue
    }
    var country: String? {
        if Locale.current.languageCode == "uk" {
            return translatedCountry
        } else {
            return originalCountry
        }
    }
    var action: String? {
        if Locale.current.languageCode == "uk" {
            return translatedAction
        } else {
            return originalAction
        }
    }
    var industrySector: String? {
        if Locale.current.languageCode == "uk" {
            return translatedGicsIndustrySector
        } else {
            return originalGicsIndustrySector
        }
    }
    var magnitudeOfOccupantOperations: String? {
        if Locale.current.languageCode == "uk" {
            return translatedMagnitudeOfOccupantOperations
        } else {
            return originalMagnitudeOfOccupantOperations
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case translatedCountry
        case translatedAction
        case translatedGicsIndustrySector
        case translatedMagnitudeOfOccupantOperations
        case originalCountry = "country"
        case originalAction = "action"
        case originalGicsIndustrySector = "gicsIndustrySector"
        case originalMagnitudeOfOccupantOperations = "magnitudeOfOccupantOperations"
        case name
        case logoURL = "logo"
        case grade
        case linkToAnnouncement
        case products
    }
}
