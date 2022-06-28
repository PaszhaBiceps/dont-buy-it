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
            
            brandImage()
                .padding(.top, 15)
            
            Text(viewModel.brand.name ?? "")
                .font(.robotoBlack(16))
                .padding(.top, 12)
            
            infoLabel()
                .padding(.top, 6)
            
            productsList()
                .padding(.bottom, 16)
        }
    }
    
    // MARK: - Views
    private func brandImage() -> some View {
        AsyncImage(url: URL(string: viewModel.brand.logoURL ?? ""))
        { image in
            image
                .resizable()
                .frame(width: 77, height: 77)
                .aspectRatio(contentMode: .fill)
                .clipShape(
                    RoundedRectangle(cornerRadius: 8,
                                     style: .continuous)
                )
                .shadow(color: .black.opacity(0.3),
                        radius: 2)
        } placeholder: {
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
        }
    }
    
    private func infoLabel() -> some View {
        let grade = viewModel.brand.gradeModel ?? GradeModel.stub()
        return InfoLabel(color: grade.color ?? .clear,
                         text: grade.name ?? "")
    }
    
    private func productsList() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                HStack {
                    Text(ViewStrings.productListTitle.localized)
                        .font(.robotoBlack(16))
                        .padding(.bottom, 22)
                        .padding(.leading, 16)
                    
                    Spacer()
                }
                
                if viewModel.brand.products.isEmpty {
                    Text(ViewStrings.noProductsPlaceholder.localized)
                        .font(.robotoRegular(16))
                } else {
                    Group {
                        ForEach(viewModel.brand.products, id: \.id) {
                            ProductItemView(product: $0)
                        }
                    }
                    .frame(width: nil)
                }
            }
        }
    }
}

// MARK: - Preview
struct BrandDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BrandDetailsView(viewModel: .init(brand: BrandModel.stub()))
    }
}
