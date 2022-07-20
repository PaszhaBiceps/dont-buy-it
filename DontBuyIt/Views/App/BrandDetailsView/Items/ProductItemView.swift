//
//  ProductItemView.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 02.06.2022.
//

import SwiftUI

struct ProductItemView: View {
    
    @State var product: ProductModel
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.imageUrl ?? ""))
            { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(
                        Circle()
                    )
                    .padding(.leading, 16)
            } placeholder: {
                Image(.placeholderSmall)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(
                        Circle()
                    )
                    .padding(.leading, 16)
            }

            
            Text(product.name ?? "")
                .font(.robotoMedium(16))
                .padding(.leading, 8)
            
            Spacer()
        }.frame(width: nil)
    }
}

struct ProductItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProductItemView(product: ProductModel.stub())
    }
}
