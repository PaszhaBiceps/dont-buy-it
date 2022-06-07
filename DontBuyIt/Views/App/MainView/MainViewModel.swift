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
    
    @Published var activeDataSource: DatasourceType
    @Published var brands: [Int]
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.activeDataSource = .left
        self.brands = [1, 2, 3, 4, 5, 6]
    }
    
    func fetchGrades() {
        API.shared.fetchGrades().sink(receiveCompletion: { completion in
            
        }, receiveValue: { grades in
            
        }).store(in: &cancellables)
    }
}
