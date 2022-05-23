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
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    NavigationHeaderView()
                }
                
                HStack {
                    Spacer()
                    Button {
                        
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
//            ScrollView {
//                LazyHStack(spacing: 10) {
//                    ForEach(0..<10) { index in
//                        AppButton(action: {
//
//                        }, showDot: false,
//                                  activeColor: .white,
//                                  text: "Button \(index)",
//                                  isActive: .constant(false))
//                    }
//                }
//            }
//            .frame(width: .infinity, height: 50)
//            .padding(.top, 25)
            
            Spacer()
            
            Text("Wow")
            
            Spacer()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
