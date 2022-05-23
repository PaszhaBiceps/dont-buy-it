//
//  MainView.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 22.05.2022.
//

import SwiftUI

struct MainView: View {
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
