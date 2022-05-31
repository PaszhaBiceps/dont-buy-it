//
//  BrandListItemViewModel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 31.05.2022.
//

import Foundation
import SwiftUI

class BrandListItemViewModel: ObservableObject {
    
    enum BrandProduct {
        case brand(imageURL: String)
        case additionalCount(_ count: Int)
        
        var id: String {
            switch self {
            case .brand(let imageURL):
                return imageURL
            case .additionalCount:
                return "additionalCount"
            }
        }
    }
    
    //FIXME: Add proper brand model when available
    @Published var brand: String
    @Published var products: [BrandProduct]
    
    init(brand: String,
         products: [Int]) {
        self.brand = brand
        // FIXME: Use proper products when available
        if products.count > 3 {
            self.products = products.prefix(2).map({
                .brand(imageURL: "\($0)")
            })
            self.products.append(
                .additionalCount(products.count - 2)
            )
        } else {
            self.products = products.map({
                .brand(imageURL: "\($0)")
            })
        }
    }
}
