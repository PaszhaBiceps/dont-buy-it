//
//  BrandDetailsViewModel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 02.06.2022.
//

import Foundation

class BrandDetailsViewModel: ObservableObject {
    
    //FIXME: Add proper models when available
    @Published var brand: String
    @Published var products: [String]
    
    init(brand: String) {
        self.brand = brand
        self.products = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    }
}
