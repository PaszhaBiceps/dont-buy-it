//
//  MainView.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 22.05.2022.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject private var viewModel = MainViewModel()
    private var isLeftDatasourceSelected: Binding<Bool> {
        Binding<Bool>(get: {
            return viewModel.activeDataSource == .left
        }, set: { _ in
           
        })
    }
    private var isStayedDatasourceSelected: Binding<Bool> {
        Binding<Bool>(get: {
            return viewModel.activeDataSource == .stayed
        }, set: { _ in
            
        })
    }
    @State private var showNotes: Bool = false
    @State private var brandToShow: BrandModel?
    private var showBrandDetails: Binding<Bool> {
        Binding<Bool>(get: {
            return brandToShow != nil
        }, set: { _ in
            
        })
    }
    
    var body: some View {
        ZStack {
            VStack {
                headerView()
                
                datasourceButtonsView()
                    .padding(.top, 10)
                    .padding(.horizontal, 16)
                
                brandsList()
            }
            
            if showNotes {
                NotesView(dismiss: $showNotes)
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: showBrandDetails) {
            if let brand = brandToShow {
                BrandDetailsView(viewModel: .init(brand: brand))
                    .onDisappear {
                        brandToShow = nil
                    }
            }
        }
    }
    
    // MARK: - Views
    private func headerView() -> some View {
        ZStack {
            HStack {
                Button {
                    viewModel.updateAppData()
                } label: {
                    if viewModel.loadingState == .loading {
                        ActivityIndicator(isAnimating: .constant(true),
                                          style: .medium)
                    } else {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.black)
                    }
                }
                .padding(.leading, 16)

                Spacer()
            }
            
            HStack {
                NavigationHeaderView()
            }
            
            HStack {
                Spacer()
                
                Button {
                    showNotes.toggle()
                } label: {
                    Image(.infoIcon)
                }
                .padding(.trailing, 16)
            }
        }
    }
    
    private func datasourceButtonsView() -> some View {
        HStack(spacing: 10) {
            AppButton(isActive: isLeftDatasourceSelected,
                      showDot: true,
                      activeColor: .green,
                      text: ViewStrings.mainScreenLeftButtonTitle.localized.uppercased(),
                      verticalPadding: 12,
                      action: {
                viewModel.changeActiveDataSource(to: .left)
            })
            
            AppButton(isActive: isStayedDatasourceSelected,
                      showDot: true,
                      activeColor: .red,
                      text: ViewStrings.mainScreenRightButtonTitle.localized.uppercased(),
                      verticalPadding: 12,
                      action: {
                viewModel.changeActiveDataSource(to: .stayed)
            })
        }
    }
    
    private func brandsList() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 22) {
                ForEach(viewModel.brands, id: \.id) { brand in
                    BrandListItemView(
                        viewModel: .init(brand: brand)
                    )
                    .padding(.horizontal, 16)
                    .onTapGesture {
                        brandToShow = brand
                    }
                }
            }.padding(.top, 5)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
