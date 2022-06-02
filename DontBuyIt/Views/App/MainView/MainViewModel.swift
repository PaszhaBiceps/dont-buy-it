//
//  MainViewModel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 02.06.2022.
//

import Foundation

class MainViewModel: ObservableObject {
    
    enum DatasourceType {
        case left
        case stayed
    }
    
    @Published var activeDataSource: DatasourceType
    @Published var brands: [Int]
    
    init() {
        self.activeDataSource = .left
        self.brands = [1, 2, 3, 4, 5, 6]
    }
}
