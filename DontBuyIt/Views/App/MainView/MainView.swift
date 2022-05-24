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
    
    var body: some View {
        ZStack {
            VStack {
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
                .padding(.top, 10)
                .padding(.horizontal, 16)
                
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
                    .padding(.top, 15)
                    
                Spacer()
            }
            
            if showNotes {
                NotesView(dismiss: $showNotes)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
