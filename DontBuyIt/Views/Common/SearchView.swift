//
//  SearchView.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 20.07.2022.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var placeholder: String
    @Binding var text: String
    
    private var backgroundColor: Color {
        colorScheme == .dark ? Color.appDarkGray : .white
    }
    
    var body: some View {
        HStack {
            Image(.searchIcon)
                .padding(.leading, 8)
            
            TextField(placeholder,
                      text: $text)
            .textFieldStyle(.automatic)
            .tint(.red)
            .padding(.trailing, 8)
        }
        .frame(height: 50)
        .background(
            Capsule()
                .foregroundColor(backgroundColor)
        )
        .clipShape(
            Capsule()
        )
        .shadow(color: .black.opacity(0.3), radius: 3)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(placeholder: "Placeholder",
                   text: .constant(""))
            .padding(.horizontal, 24)
    }
}
