//
//  BrandModel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 02.06.2022.
//

import Foundation

struct BrandModel: APIModel,
                   Codable {
    
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
    var products: [ProductModel]
    var gradeModel: GradeModel?
    
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
    
    // MARK: - Public
    mutating func updateGradeModel(_ model: GradeModel) {
        gradeModel = model
    }
    
    mutating func updateProducts(_ list: [ProductModel]) {
        products = list
    }
    
    // MARK: - Convenience
    static func stub() -> BrandModel {
        var stub = BrandModel(
            translatedCountry: "Карїна",
            translatedAction: "Дія",
            translatedGicsIndustrySector: "Сектор",
            translatedMagnitudeOfOccupantOperations: "Магнітуда Операцій",
            originalCountry: "Country",
            originalAction: "Action",
            originalGicsIndustrySector: "Sector",
            originalMagnitudeOfOccupantOperations: "Magnitude of Operations",
            name: "Brand",
            logoURL: nil,
            grade: "Grade",
            linkToAnnouncement: nil,
            products: [ProductModel.stub()]
        )
        stub.updateGradeModel(GradeModel.unknown())
        return stub
    }
}
