//
//  PersistantModels+Init.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 27.06.2022.
//

import CoreData

extension Grade {
    convenience init(response: GradeModel,
                     context: NSManagedObjectContext) {
        self.init(entity: Grade.entity(),
                  insertInto: context)
        avalaibleForPurchase = response.availableForPurchase
        colorHexString = response.colorHexString
        displayName = response.displayName
        gradeDescription = response.description
        name = response.name
        priority = Int64(response.priority ?? 0)
    }
}

extension Product {
    convenience init(response: ProductModel, context: NSManagedObjectContext) {
        self.init(entity: Product.entity(),
                  insertInto: context)
        brandName = response.brandName
        imageUrl = response.imageUrl
        name = response.name
    }
}

extension Brand {
    convenience init(response: BrandModel,
                     context: NSManagedObjectContext) {
        self.init(entity: Brand.entity(),
                  insertInto: context)
        grade = response.grade
        linkToAnnouncement = response.linkToAnnouncement
        logoURL = response.logoURL
        name = response.name
        response.products.forEach {
            addToProducts(
                Product(response: $0,
                        context: context)
            )
        }
        originalAction = response.originalAction
        originalCountry = response.originalCountry
        originalGicsIndustrySector = response.originalGicsIndustrySector
        originalMagnitudeOfOccupantOperations = response.originalMagnitudeOfOccupantOperations
        translatedAction = response.translatedAction
        translatedCountry = response.translatedCountry
        translatedGicsIndusctrySector = response.translatedGicsIndustrySector
        translatedMagnitudeOfOccupantOperations = response.translatedMagnitudeOfOccupantOperations
    }
}
