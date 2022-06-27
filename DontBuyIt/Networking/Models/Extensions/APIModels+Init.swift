//
//  APIModels+Init.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 27.06.2022.
//

import Foundation

extension GradeModel {
    init(dbModel: Grade) {
        self.init(
            originalName: dbModel.name,
            translatedName: dbModel.displayName,
            description: dbModel.gradeDescription,
            colorHexString: dbModel.colorHexString,
            priority: Int(dbModel.priority),
            availableForPurchase: dbModel.avalaibleForPurchase
        )
    }
}

extension ProductModel {
    init(dbModel: Product) {
        self.init(
            name: dbModel.name,
            brandName: dbModel.brandName,
            imageUrl: dbModel.imageUrl
        )
    }
}

extension BrandModel {
    init(dbModel: Brand) {
        let products = dbModel.products?.map({
            ProductModel(dbModel: $0 as! Product)
        }) ?? []
        
        self.init(
            translatedCountry: dbModel.translatedCountry,
            translatedAction: dbModel.translatedAction,
            translatedGicsIndustrySector: dbModel.translatedGicsIndusctrySector,
            translatedMagnitudeOfOccupantOperations: dbModel.translatedMagnitudeOfOccupantOperations,
            originalCountry: dbModel.originalCountry,
            originalAction: dbModel.originalAction,
            originalGicsIndustrySector: dbModel.originalGicsIndustrySector,
            originalMagnitudeOfOccupantOperations: dbModel.originalMagnitudeOfOccupantOperations,
            name: dbModel.name,
            logoURL: dbModel.logoURL,
            grade: dbModel.grade,
            linkToAnnouncement: dbModel.linkToAnnouncement,
            products: products
        )
    }
}
