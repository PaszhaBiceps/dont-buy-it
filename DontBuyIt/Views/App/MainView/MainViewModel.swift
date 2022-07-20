//
//  MainViewModel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 02.06.2022.
//

import Foundation
import Combine

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
}
