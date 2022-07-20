//
//  SplashViewModel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 07.06.2022.
//

import Foundation
import Combine

@MainActor
class SplashViewModel: ObservableObject {
    
    enum State: Equatable {
        case idle
        case loading
        case finished
        case error(message: String)
    }
    
    @Published var loadingState: State = .idle
    
    init() {}
    
    // MARK: - Public
    func fetchDataIfNeeded() {
        let storage = Storage.shared
        
        loadingState = .loading
        if storage.hasAllDataLoaded() {
            loadingState = .finished
            return
        }
                
        Task {
            do {
                async let grades = try API.shared.fetchGrades()
                async let brands = try API.shared.fetchBrands()
                async let products = try API.shared.fetchProducts()

                try await store(grades: grades,
                                brands: brands,
                                products: products,
                                storage: storage)
                await MainActor.run(body: {[weak self] in
                    self?.loadingState = .finished
                })
            } catch let error {
                await MainActor.run(body: {[weak self] in
                    self?.loadingState = .error(message: error.localizedDescription)
                })
            }
        }
    }
    
    // MARK: - Private
    func store(grades: [GradeModel],
               brands: [BrandModel],
               products: [ProductModel],
               storage: Storage) {
        storage.store(data: (brands, products, grades))
    }
}
