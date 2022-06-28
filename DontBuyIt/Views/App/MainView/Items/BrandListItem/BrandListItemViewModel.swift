//
//  BrandListItemViewModel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 31.05.2022.
//

import Foundation

class BrandListItemViewModel: ObservableObject {
    
    enum BrandProduct {
        case product(_ model: ProductModel)
        case additionalCount(_ count: Int)
        
        var id: Int {
            switch self {
            case .product(let model):
                return model.id
            case .additionalCount:
                return "additionalCount".hashValue
            }
        }
    }
    
    @Published var brand: BrandModel
    @Published var products: [BrandProduct]
    
    init(brand: BrandModel) {
        self.brand = brand
        if brand.products.count > 3 {
            self.products = brand.products.prefix(2).map({ .product($0) })
            self.products.append(
                .additionalCount(brand.products.count - 2)
            )
        } else {
            self.products = brand.products.map({ .product($0) })
        }
    }
}
