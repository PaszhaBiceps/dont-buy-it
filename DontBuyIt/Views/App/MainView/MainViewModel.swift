//
//  MainViewModel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 02.06.2022.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    
    enum DatasourceType {
        case left
        case stayed
    }
    
    @Published var activeDataSource: DatasourceType = .left
    @Published var brands: [BrandModel] = []
    private var storage: Storage?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {}
    
    // MARK: - Public
    func prepareInfo(storage: Storage) {
        self.storage = storage
        brands = storage.getBrands()
    }
}
