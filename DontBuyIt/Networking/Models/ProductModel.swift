//
//  ProductModel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 02.06.2022.
//

import Foundation

struct ProductModel: APIModel,
                     Codable {
    let name: String?
    let brandName: String?
    let imageUrl: String?
    
    var id: Int {
        return (name ?? "").hashValue
    }
    
    // MARK: - Convenience
    static func stub() -> Self {
        return ProductModel(name: "Product",
                            brandName: "Brand",
                            imageUrl: nil)
    }
}
