//
//  MainViewModel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 02.06.2022.
//

import Foundation
import Combine

@MainActor
final class MainViewModel: ObservableObject {
    
    enum DatasourceType {
        case left
        case stayed
        
        var priorityRange: ClosedRange<Int> {
            switch self {
            case .left:
                return 0...2
            case .stayed:
                return 3...6
            }
        }
    }
    
    enum State: Equatable {
        case idle
        case loading
        case error(message: String)
    }
    
    @Published var loadingState: State = .idle
    @Published var activeDataSource: DatasourceType = .left
    @Published var brands: [BrandModel] = []
    
    private var allBrands: [BrandModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        allBrands = Storage.shared.getBrands()
        changeActiveDataSource(to: .left)
    }
    
    // MARK: - Public
    func changeActiveDataSource(to dataSource: DatasourceType) {
        activeDataSource = dataSource
        brands = allBrands.filter({
            guard let priority = $0.gradeModel?.priority else {
                return false
            }
            return activeDataSource.priorityRange.contains(priority)
        })
    }
    
    /**
     Updates all data stored in CoreData and refrehes the list afterwards
     */
    func updateAppData() {
        loadingState = .loading
        Task {
            do {
                async let data = try API.shared.fetchData()
                try await Storage.shared.store(data: data)
                await MainActor.run(body: {[weak self] in
                    self?.loadingState = .idle
                    self?.allBrands = Storage.shared.getBrands()
                    self?.changeActiveDataSource(to: self?.activeDataSource ?? .left)
                })
            } catch {
                await MainActor.run(body: {[weak self] in
                    self?.loadingState = .error(message: error.localizedDescription)
                })
            }
        }
    }
}
