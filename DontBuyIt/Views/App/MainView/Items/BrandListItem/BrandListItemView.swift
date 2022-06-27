//
//  BrandListItemView.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 24.05.2022.
//

import SwiftUI

struct BrandListItemView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: BrandListItemViewModel
    
    private var backgroundColor: Color {
        colorScheme == .dark ? Color.appDarkGray : .white
    }
    
    var body: some View {
        HStack {
            mainImage()
                .padding(.vertical, 12)
                .padding(.leading, 12)
            
            contentStack()
            
            Spacer()
        }.frame(width: nil)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(colorScheme == .dark ? .appDarkGray : .white)
                    .shadow(color: .black.opacity(0.3),
                            radius: 3)
            )
    }
    
    // MARK: - Views
    private func mainImage() -> some View {
        Image(.placeholder)
            .resizable()
            .frame(width: 76,
                   height: 76)
            .aspectRatio(contentMode: .fill)
            .clipShape(
                RoundedRectangle(cornerRadius: 8,
                                 style: .continuous)
            )
            .shadow(color: .black.opacity(0.3),
                    radius: 2)
    }
    
    private func contentStack() -> some View {
        VStack(alignment: .leading,
               spacing: 12) {
            Text(viewModel.brand.name ?? "")
                .font(.robotoBlack(16))
                .foregroundColor(
                    colorScheme == .dark ? .white : .appDarkGray
                )
            
            LazyHStack(spacing: 4) {
                ForEach(viewModel.products, id: \.id) { item in
                    switch item {
                    case .brand(let model):
                        if let imageUrl = model.imageUrl,
                           imageUrl.isEmpty {
                            // FIXME: Actually load image
                            Image(.placeholderSmall)
                                .resizable()
                                .frame(width: 18,
                                       height: 18)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(
                                    Circle()
                                )
                        } else {
                            Image(.placeholderSmall)
                                .resizable()
                                .frame(width: 18,
                                       height: 18)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(
                                    Circle()
                                )
                        }
                    case .additionalCount(let count):
                        Text("+\(count > 99 ? 99 : count)")
                            .frame(width: 18,
                                   height: 18)
                            .font(.robotoBlack(8))
                            .foregroundColor(.white)
                            .background(
                                Color.appGray
                            )
                            .clipShape(
                                Circle()
                            )
                    }
                }
            }.frame(height: 18)
            
            InfoLabel(color: .green,
                      text: "Text")
        }
    }
}

struct BrandListItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BrandListItemView(viewModel: .init(brand: BrandModel.stub(),
                                               products: [ProductModel.stub()]))
                .padding(.horizontal, 26)
            
            Spacer()
        }
    }
}
