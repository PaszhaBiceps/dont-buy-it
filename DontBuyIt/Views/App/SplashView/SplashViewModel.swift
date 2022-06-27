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
        case finished(error: String?)
    }
    
    @Published var loadingState: State = .idle
    
    init() {}
    
    // MARK: - Public
    func fetchDataIfNeeded(_ storage: Storage) {
        loadingState = .loading
        if !storage.getBrands().isEmpty,
           !storage.getGrades().isEmpty,
           !storage.getProducts().isEmpty {
            loadingState = .finished(error: nil)
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
                    self?.loadingState = .finished(error: nil)
                })
            } catch {
                await MainActor.run(body: {[weak self] in
                    self?.loadingState = .finished(error: error.localizedDescription)
                })
            }
        }
    }
    
    // MARK: - Private
    func store(grades: [GradeModel],
               brands: [BrandModel],
               products: [ProductModel],
               storage: Storage) {
        storage.store(grades: grades)
        storage.store(brands: brands)
        storage.store(products: products)
    }
}
