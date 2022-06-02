//
//  BrandDetailsView.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 02.06.2022.
//

import SwiftUI

struct BrandDetailsView: View {
    
    @ObservedObject var viewModel: BrandDetailsViewModel
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.appDarkGray)
                .frame(width: 44, height: 4)
                .cornerRadius(1.5)
                .padding(.top, 7)
            
            Image(.placeholder)
                .resizable()
                .frame(width: 77, height: 77)
                .aspectRatio(contentMode: .fill)
                .clipShape(
                    RoundedRectangle(cornerRadius: 8,
                                     style: .continuous)
                )
                .shadow(color: .black.opacity(0.3),
                        radius: 2)
                .padding(.top, 15)
            
            Text(viewModel.brand)
                .font(.robotoBlack(16))
                .padding(.top, 12)
            
            InfoLabel(color: .red,
                      text: "Text")
            .padding(.top, 6)
            
            Text("Date")
                .font(.robotoMedium(14))
                .foregroundColor(.appLightGray)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    HStack {
                        Text(ViewStrings.productListTitle.localized)
                            .font(.robotoBlack(16))
                            .padding(.bottom, 22)
                            .padding(.leading, 16)
                        
                        Spacer()
                    }
                    
                    Group {
                        ForEach(viewModel.products, id: \.self) { product in
                            ProductItemView(imageUrl: "", name: "Product \(product)")
                        }
                    }
                    .frame(width: nil)
                    .padding(.bottom, 16)
                }
            }
        }
    }
}

struct BrandDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BrandDetailsView(viewModel: .init(brand: "Noice Brand"))
    }
}
