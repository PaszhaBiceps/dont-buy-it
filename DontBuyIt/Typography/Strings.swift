//
//  Strings.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 22.05.2022.
//

import Foundation

enum ViewStrings: String,
                  Localizable {
    case navigationHeaderPartOne = "navigation_header_part_one"
    case navigationHeaderPartTwo = "navigation_header_part_two"
    
    case mainScreenLeftButtonTitle = "main_screen_left_button_title"
    case mainScreenRightButtonTitle = "main_screen_right_button_title"
    case mainScreenSearachBarPlaceholder = "main_screen_search_bar_placeholder"
    
    case notesViewTitle = "notes_view_title"
    case temprorarySuspendedTitle = "temropary_suspended_title"
    case temporarySuspendedDescription = "temporary_suspended_description"
    case reductionOfBusinessTitle = "reduction_of_business_title"
    case reductionOfBusinessDescription = "reduction_of_business_description"
    case suspensionOfInvestmentsTitle = "suspension_of_investments_title"
    case suspensionOfInvestmentsDescription = "suspension_of_investments_description"
    case workInTheCountryOfTheAggressorTitle = "work_in_the_country_of_the_aggressor_title"
    case workInTheCountryOfTheAggressorDescription = "work_in_the_country_of_the_aggressor_description"
    case russianBrandTitle = "russian_brand_title"
    case russianBrandDescritpion = "russian_brand_description"
    case closeButtonTitle = "close_button_title"
    
    case productListTitle = "product_list_title"
    case noProductsPlaceholder = "no_products_placeholder"
    
    case loadingResourceMessage = "loading_resources_message"
    case failedToLoadReourcesMessage = "failed_to_load_resources_message"
    case retryActionTitle = "retry_action_title"
}

struct Constants {
    static let baseURL = "https://dont-buy-it-diploma.herokuapp.com"
    
    enum Paths: String {
        case grades = "/api/grades"
        case products = "/api/products"
        case brands = "/api/brands"
    }
}
