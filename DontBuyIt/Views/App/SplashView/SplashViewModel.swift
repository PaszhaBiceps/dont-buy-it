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
    func fetchDataIfNeeded() {
        // FIXME: Check if CoreData already contains info and it actually needs loading
        loadingState = .loading
        Task {
            do {
                async let grades = try API.shared.fetchGrades()
                async let brands = try API.shared.fetchBrands()
                
                try await store(grades: grades,
                                brands: brands)
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
    
    func store(grades: [GradeModel],
               brands: [BrandModel]) {
        
    }
}
