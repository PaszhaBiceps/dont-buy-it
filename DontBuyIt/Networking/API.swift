//
//  API.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 07.06.2022.
//

import Foundation
import Networking
import Combine

struct API: NetworkingService {
    static var shared = API()
    
    internal var network: NetworkingClient
    
    private init() {
        network = NetworkingClient(baseURL: Constants.baseURL)
        network.logLevel = .debug
    }
    
    func fetchGrades() -> AnyPublisher<[GradeModel], Error> {
        get(Constants.Paths.grades.rawValue)
    }
}
