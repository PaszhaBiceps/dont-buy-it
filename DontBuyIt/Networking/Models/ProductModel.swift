//
//  ProductModel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 02.06.2022.
//

import Foundation

struct ProductModel: Codable {
    let name: String?
    let brandName: String?
    let imageUrl: String?
    
    var id: Int {
        return (name ?? "").hashValue
    }
}
