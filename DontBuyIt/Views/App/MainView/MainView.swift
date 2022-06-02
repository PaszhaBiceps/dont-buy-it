//
//  MainView.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 22.05.2022.
//

import SwiftUI

struct MainView: View {
    
    enum DatasourceType {
        case left
        case stayed
    }
    
    @Environment(\.colorScheme) var colorScheme
    @State private var currentDatasource = DatasourceType.left
    private var isLeftDatasourceSelected: Binding<Bool> {
        Binding<Bool>(get: {
            return currentDatasource == .left
        }, set: { _ in
           
        })
    }
    private var isStayedDatasourceSelected: Binding<Bool> {
        Binding<Bool>(get: {
            return currentDatasource == .stayed
        }, set: { _ in
            
        })
    }
    @State private var showNotes: Bool = false
    @State private var brandToShow: String?
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
                
                searchView()
                    .padding(.top, 15)
                
                // FIXME: Replace with LazyVStack when networking is implemented
                BrandListItemView(viewModel: .init(brand: "Brand", products: [1, 2, 3, 4]))
                    .padding(.horizontal, 16)
                    .onTapGesture {
                        brandToShow = "Brand"
                    }
                
                Spacer()
            }
            
            if showNotes {
                NotesView(dismiss: $showNotes)
            }
        }
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
                currentDatasource = .left
            })
            
            AppButton(isActive: isStayedDatasourceSelected,
                      showDot: true,
                      activeColor: .red,
                      text: ViewStrings.mainScreenRightButtonTitle.localized.uppercased(),
                      verticalPadding: 12,
                      action: {
                currentDatasource = .stayed
            })
        }
    }
    
    private func searchView() -> some View {
        ScrollView(.horizontal,
                   showsIndicators: false) {
            LazyHStack(spacing: 10) {
                Section {
                    ForEach(0..<10) { index in
                        AppButton(isActive: .constant(false),
                                  activeColor: .white,
                                  text: "Button \(index)",
                                  verticalPadding: 7,
                                  horizontalPadding: 12) {
                            
                        }
                    }
                } header: {
                    SearchButton {
                        
                    }
                }
            }.padding(.horizontal, 16)
        }.frame(height: 60)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
