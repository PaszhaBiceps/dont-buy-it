//
//  String+Convenience.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 22.05.2022.
//

import Foundation

protocol Localizable {
    var localized: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

extension String {
    var lines: [String] {
        return self.components(separatedBy: "\n")
    }
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
}
