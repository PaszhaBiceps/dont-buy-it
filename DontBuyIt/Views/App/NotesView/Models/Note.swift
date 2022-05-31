//
//  Note.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 24.05.2022.
//

import SwiftUI

enum Note: String,
           CaseIterable {
    case temporarySuspended
    case reductionOfBusiness
    case suspensionOfInvestments
    case workInTheCountryOfAgressor
    case russianBrand
    
    var color: Color {
        switch self {
        case .temporarySuspended:
            return .appGreen
        case .reductionOfBusiness,
                .suspensionOfInvestments:
            return .appYellow
        case .workInTheCountryOfAgressor,
                .russianBrand:
            return .appRed
        }
    }
    
    var title: String {
        switch self {
        case .temporarySuspended:
            return ViewStrings
                .temprorarySuspendedTitle
                .localized
        case .reductionOfBusiness:
            return ViewStrings
                .reductionOfBusinessTitle
                .localized
        case .suspensionOfInvestments:
            return ViewStrings
                .suspensionOfInvestmentsTitle
                .localized
        case .workInTheCountryOfAgressor:
            return ViewStrings
                .workInTheCountryOfTheAggressorTitle
                .localized
        case .russianBrand:
            return ViewStrings
                .russianBrandTitle
                .localized
        }
    }
    
    var description: String {
        switch self {
        case .temporarySuspended:
            return ViewStrings
                .temporarySuspendedDescription
                .localized
        case .reductionOfBusiness:
            return ViewStrings
                .reductionOfBusinessDescription
                .localized
        case .suspensionOfInvestments:
            return ViewStrings
                .suspensionOfInvestmentsDescription
                .localized
        case .workInTheCountryOfAgressor:
            return ViewStrings
                .workInTheCountryOfTheAggressorDescription
                .localized
        case .russianBrand:
            return ViewStrings
                .russianBrandDescritpion
                .localized
        }
    }
}
