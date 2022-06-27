//
//  API.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 07.06.2022.
//

import Foundation
import Networking
import Combine

protocol APIModel {
    var id: Int { get }
    
    static func stub() -> Self
}

struct API: NetworkingService {
    static var shared = API()
    
    internal var network: NetworkingClient
    
    private init() {
        network = NetworkingClient(baseURL: Constants.baseURL)
        network.logLevel = .debug
    }
    
    func fetchGrades() async throws -> [GradeModel] {
        try await get(Constants.Paths.grades.rawValue)
    }
    
    func fetchBrands() async throws -> [BrandModel] {
        try await get(Constants.Paths.brands.rawValue)
    }
    
    func fetchProducts() async throws -> [ProductModel] {
        try await get(Constants.Paths.products.rawValue)
    }
}
