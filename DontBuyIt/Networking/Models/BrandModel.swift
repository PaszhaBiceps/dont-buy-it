//
//  BrandModel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 02.06.2022.
//

import Foundation

struct BrandModel: Codable {
    let translatedCountry: String?
    let translatedAction: String?
    let translatedGicsIndustrySector: String?
    let translatedMagnitudeOfOccupantOperations: String?
    let originalCountry: String?
    let originalAction: String?
    let originalGicsIndustrySector: String?
    let originalMagnitudeOfOccupantOperations: String?
    
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
