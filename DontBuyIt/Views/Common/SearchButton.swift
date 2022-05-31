//
//  SearchButton.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 23.05.2022.
//

import SwiftUI

struct SearchButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(.searchIcon)
        }.frame(width: 44, height: 44)
            .background(
                colorScheme == .dark ? Color.appDarkGray : .white
            )
            .cornerRadius(22)
            .shadow(color: .black.opacity(0.3),
                    radius: 2)
    }
}

struct SearchButton_Previews: PreviewProvider {
    static var previews: some View {
        SearchButton(action: {})
    }
}
