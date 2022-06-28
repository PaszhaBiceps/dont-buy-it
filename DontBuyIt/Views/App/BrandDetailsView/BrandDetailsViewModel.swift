//
//  BrandDetailsViewModel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 02.06.2022.
//

import Foundation

class BrandDetailsViewModel: ObservableObject {
    
    @Published var brand: BrandModel
    
    init(brand: BrandModel) {
        self.brand = brand
    }
}
