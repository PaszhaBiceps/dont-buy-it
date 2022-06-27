//
//  NotesViewModel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 27.06.2022.
//

import SwiftUI
import Combine

class NotesViewModel: ObservableObject {
    
    @Published var grades: [GradeModel] = []
    
    init() {
        grades = Storage.shared.getGrades().sorted(by: { ($0.priority ?? 0) < ($1.priority ?? 0) })
    }
}
