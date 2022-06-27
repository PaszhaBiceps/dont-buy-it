//
//  BrandListItemViewModel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 31.05.2022.
//

import Foundation

class BrandListItemViewModel: ObservableObject {
    
    enum BrandProduct {
        case brand(_ model: ProductModel)
        case additionalCount(_ count: Int)
        
        var id: Int {
            switch self {
            case .brand(let model):
                return model.id
            case .additionalCount:
                return "additionalCount".hashValue
            }
        }
    }
    
    @Published var brand: BrandModel
    @Published var products: [BrandProduct]
    
    init(brand: BrandModel,
         products: [ProductModel]) {
        self.brand = brand
        if products.count > 3 {
            self.products = products.prefix(2).map({ .brand($0) })
            self.products.append(
                .additionalCount(products.count - 2)
            )
        } else {
            self.products = products.map({ .brand($0) })
        }
    }
}
