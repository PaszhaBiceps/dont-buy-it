//
//  ProductItemView.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 02.06.2022.
//

import SwiftUI

struct ProductItemView: View {
    
    @State var imageUrl: String
    @State var name: String
    
    var body: some View {
        HStack {
            // FIXME: Add loading from URL when available
            Image(.placeholder)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 45, height: 45)
                .clipShape(
                    Circle()
                )
                .padding(.leading, 16)
            
            Text(name)
                .font(.robotoMedium(16))
                .padding(.leading, 8)
            
            Spacer()
        }.frame(width: nil)
    }
}

struct ProductItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProductItemView(imageUrl: "",
                        name: "Brand Name")
    }
}
